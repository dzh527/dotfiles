return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.scroll = opts.scroll or {}
      opts.scroll.enabled = false

      local git = require("snacks.explorer.git")
      if git._clear_stale_dir_status then
        return
      end

      local update = git._update
      git._update = function(cwd, results)
        local tree = require("snacks.explorer.tree")
        local cleared = false

        tree:walk(tree:find(cwd), function(node)
          if node.dir_status ~= nil then
            node.dir_status = nil
            cleared = true
          end
        end, { all = true })

        return update(cwd, results) or cleared
      end
      git._clear_stale_dir_status = true
    end,
  },
}
