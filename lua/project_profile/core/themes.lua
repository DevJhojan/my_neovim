local M = {}

M.default = {
  name = "default",
  completion = "none",
  theme = {
    background = "#12070C",
    background_proportion = 60,
    foreground = "#F4E6E6",
    foreground_proportion = 30,
    accent = "#FF2E63",
    accent_proportion = 10,
    secondary = "#A4133C",
    secondary_proportion = 10,
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

M.bash = {
  name = "bash",
  completion = "bashls",
  theme = {
    ["#16141F"] = 60,
    ["#E0DEF4"] = 30,
    ["#9CCFD8"] = 10,
  },
}

M.rust = {
  name = "rust",
  completion = "rust_analyzer",
  theme = {
    ["#0F1A2B"] = 60,
    ["#EDE6D6"] = 30,
    ["#F74C3C"] = 10,
  },
}

M.godot = {
  name = "godot",
  completion = "gdscript",
  theme = {
    background = "#141B26",
    background_proportion = 60,
    foreground = "#E3EAF2",
    foreground_proportion = 30,
    keyword = "#5FD4F4",
    keyword_proportion = 10,
  },
}

return M
