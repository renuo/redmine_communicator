defmodule RedmineCommunicator.RedmineServiceTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "#toggl_entries_per_user" do
    toggl_entries = RedmineCommunicator.RedmineService.toggl_entries_per_user(fake_response_from("test/fixtures/toggl_entries_list.xml"))
    toggl_entry = Enum.at(toggl_entries['roger.tester@renuo.ch'], 0)
    assert_entry(toggl_entry, 'roger.tester@renuo.ch', 'Roger Tester', '0.01 Stunde (Feature #916 (To Specify): Auto time entries)', '\n')
  end

  test "#toggl_entries_per_user with longer input" do
    toggl_entries = RedmineCommunicator.RedmineService.toggl_entries_per_user(fake_response_from("test/fixtures/longer_toggl_entries_list.xml"))
    toggl_entry1 = Enum.at(toggl_entries['roger.tester@renuo.ch'], 0)
    assert Map.size(toggl_entries) == 2
    assert length(toggl_entries['roger.tester@renuo.ch']) == 2
    assert length(toggl_entries['pascal.tester@renuo.ch']) == 1
    toggl_entry1 = Enum.at(toggl_entries['roger.tester@renuo.ch'], 0)
    assert_entry(toggl_entry1, 'roger.tester@renuo.ch', 'Roger Tester', '1.15 Stunde (Feature #916 (To Specify): Auto time entries)', '\n')
    toggl_entry2 = Enum.at(toggl_entries['roger.tester@renuo.ch'], 1)
    assert_entry(toggl_entry2, 'roger.tester@renuo.ch', 'Roger Tester', '0.01 Stunde (Feature #916 (To Specify): Auto time entries)', '\n')
    toggl_entry3 = Enum.at(toggl_entries['pascal.tester@renuo.ch'], 0)
    assert_entry(toggl_entry3, 'pascal.tester@renuo.ch', 'Pascal Tester', '0.11 Stunde (Feature #916 (To Specify): Auto time entries)', '\n')

  end

  def fake_response_from(path) do
    file_read = File.read!(path)    
    %{body: file_read}
  end

  def assert_entry(toggl_entry, expected_email, expected_author, expected_title, expected_content) do
    assert toggl_entry[:email] == expected_email
    assert toggl_entry[:author] == expected_author
    assert toggl_entry[:title] == expected_title
    assert toggl_entry[:content] == expected_content
  end
end
