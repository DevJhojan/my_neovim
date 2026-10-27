package.path = package.path .. ";tests/ts_detection_spec/?.lua"

local cases = {
  require("01_ts_persist_profile"),
  require("02_ts_restore_saved_profile"),
  require("03_ts_update_profile"),
  require("04_ts_select_when_missing"),
  require("05_ts_activate_lsp"),
  require("06_ts_preserve_other_servers"),
}

for _, test_case in ipairs(cases) do
  test_case()
end
