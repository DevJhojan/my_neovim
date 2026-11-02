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

M.django = {
  name = "django",
  completion = "django",
  theme = {
    orange = 60,
    green = 30,
    white = 10,
  },
}

M.typescript = {
  name = "typescript",
  completion = "ts_ls",
  theme = {
    blue = 60,
    cyan = 30,
    white = 10,
  },
}

M.react = {
  name = "react",
  completion = "ts_ls",
  theme = {
    blue = 60,
    lime = 30,
    white = 10,
  },
}

M["react-native"] = {
  name = "react-native",
  completion = "ts_ls",
  theme = {
    blue = 60,
    purple = 30,
    white = 10,
  },
}

return M
