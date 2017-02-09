defmodule RedmineCommunicator.Email do
  use Bamboo.Phoenix, view: RedmineCommunicator.EmailView

  def send_unhandled_toggl_entry_reminder(email_address, time_entries) do
    new_email()
    |> to("#{email_address}")
    |> from("#{Application.get_env(:redmine_communicator, RedmineCommunicator.Email)[:sender_email]}")
    |> subject("Please handle your 916 toggle-entries")
    |> text_body(
        "Hey there!\n"
        <> "In order to send correct invoices, all time entries must be associated to a project.\n"
        <> "Unfortunately, there are unhandled toggle-entries from your account. "
        <> "Please allocate them to a project by moving it to the correct tickets:\n"
        <> "#{Application.get_env(:redmine_communicator, RedmineCommunicator.RedmineService)[:redmine_url]}/issues/916/time_entries\n" 
        <> "#{time_entries}\n"
        <> "Thanks in advance!"
      )
  end
end
