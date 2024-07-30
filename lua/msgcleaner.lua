local M = {}

local cthulhu = require("cthulhu")
local augroups = require("infra.augroups")
local iuv = require("infra.iuv")
local ni = require("infra.ni")
local strlib = require("infra.strlib")

local aug = nil ---@type infra.Augroup?
local timer = iuv.new_timer() ---@type uv_timer_t

function M.activate()
  if aug then return end

  local last_cmd = 0
  aug = augroups.Augroup("msgclearer://")
  aug:repeats("CmdlineLeave", { callback = function() last_cmd = os.time() end })

  local last_clear = 0

  local function clean()
    if strlib.startswith(ni.get_mode().mode, "c") then return end
    local last_msg = cthulhu.nvim.last_msg_time()

    local last_activity = math.max(last_msg, last_cmd)
    if last_activity <= last_clear then return end

    local now = os.time()
    if now - last_activity < 5 then return end

    last_clear = last_activity
    ni.echo({ { "" } }, false, { verbose = false })
  end

  timer:stop()
  timer:start(1000, 1000, vim.schedule_wrap(clean))
end

function M.deactivate()
  if aug == nil then return end

  timer:stop()
  aug:unlink()
  aug = nil
end

return M
