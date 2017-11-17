import SweetXml

defmodule RedmineCommunicator.RedmineService do

  def run_toggl_time_entries_reminder do
    key = Application.get_env(:redmine_communicator, RedmineCommunicator.RedmineService)[:redmine_atom_key]
    url = "#{Application.get_env(:redmine_communicator, RedmineCommunicator.RedmineService)[:redmine_url]}/issues/916/time_entries.atom"
    response = HTTPotion.get(url, query: %{key: key})
    if  HTTPotion.Response.success?(response) do
      send_reminder_for(toggl_entries_per_user(response))
    end
  end

  def toggl_entries_per_user(response) do
    xml_string = response.body
    doc = xml_string |> parse
    raw_entries = doc |> xpath(
      ~x"//entry"l,
      title: ~x"./title/text()",
      updated: ~x"./updated/text()",
      author: ~x"./author/name/text()",
      email: ~x"./author/email/text()",
      content: ~x"./content/text()"
    )
    result = raw_entries |> Enum.group_by((fn element -> element[:email] end))
    result
  end

  def filter_title(entry) do
    entry[:title]
    |> to_string
    |> String.replace("/n","")
  end

  def filter_content(entry) do
    entry[:content]
    |> to_string
    |> String.strip
  end

  def generate_time_entries(entries) do
    time_entries = Enum.reduce(entries, "", fn(entry, acc) -> "#{acc}* #{filter_title(entry)} #{filter_content(entry)}\n" end)
    time_entries
    |> to_string
    |> String.replace("<p>", "")
    |> String.replace("</p>", "") 
  end
  
  def send_reminder_for(toggl_entries_per_user) do
    for {email, entries} <- toggl_entries_per_user do
      time_entries = generate_time_entries(entries)          
      IO.inspect email
      IO.inspect time_entries
      RedmineCommunicator.Email.send_unhandled_toggl_entry_reminder(email, time_entries) |> RedmineCommunicator.Mailer.deliver_now
    end
  end
end