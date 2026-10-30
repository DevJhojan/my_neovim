local M = {}

M.default = {
  name = "default",
  completion = "none",
  theme = {
    black = 60,
    Red = 30,
    white = 10,
  },
}

M.python = {
  name = "python",
  completion = "pyright",
  theme = {
    yellow = 60,
    blue = 30,
    white = 10,
  },
}

return M
