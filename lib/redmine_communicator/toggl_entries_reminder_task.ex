defmodule Mix.Tasks.RedmineCommunicator.TogglEntriesReminder do
  use Mix.Task

  def run(_args) do
    Mix.shell.info "Send toggl reminder is started."
    HTTPotion.start
    :application.ensure_all_started(:bamboo)
    RedmineCommunicator.RedmineService.run_toggl_time_entries_reminder
    Mix.shell.info "Finished sending toggl reminder.l"  
  end
end