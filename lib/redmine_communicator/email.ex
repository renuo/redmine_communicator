defmodule RedmineCommunicator.Email do
  use Bamboo.Phoenix, view: RedmineCommunicator.EmailView
  
  def send_unhandled_toggl_entry_reminder(email_address, time_entries) do
    new_email()
    |> to("#{email_address}")
    |> from({"Toggle Reminder", Application.get_env(:redmine_communicator, RedmineCommunicator.Email)[:sender_email]})
    |> subject("Please handle your 916 toggle-entries")
    |> Bamboo.SparkPostHelper.disable_open_tracking
    |> Bamboo.SparkPostHelper.disable_click_tracking
    |> text_body(
        "Hey there!\n"
        <> "In order to send correct invoices, all time entries must be associated to a project.\n"
        <> "Unfortunately, there are unhandled toggle-entries from your account. "
        <> "Please allocate them to a project by moving it to the correct tickets:\n"
        <> "#{Application.get_env(:redmine_communicator, RedmineCommunicator.RedmineService)[:redmine_url]}/projects/toggle-auto-time-entries/time_entries?issue_id=~916\n"
        <> "#{time_entries}\n"
        <> "You might find the right ticket here: #{Application.get_env(:redmine_communicator, RedmineCommunicator.RedmineService)[:redmine_url]}/projects/internal/wiki/Renuo_FAQ#Renuo-FAQ\n"
        <> "Or here #{Application.get_env(:redmine_communicator, RedmineCommunicator.RedmineService)[:dashboard_url]}\n"
        <> "Thanks in advance!"
      )
  end
end
