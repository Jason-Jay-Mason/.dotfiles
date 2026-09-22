local ok, rosepine = pcall(require, 'rose-pine')

if not ok then
  return
end

rosepine.setup({
  dim_nc_background = true,
  disable_background = true,
  disable_float_background = true,
})
