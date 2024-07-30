
## motivation, designs, features, limits
* there are two kind of messages AFAIK
  * the excmd itself: `sleep 1`. some EXs will not clean the cmdline
  * message delivered by `:echo`, `nvim_echo` ...
* sometimes the message left on the cmdline is outdated, meaningless
* so i made this plugin to clean them periodically

## warning
it requires [a patch of nvim](https://github.com/haolian9/neovim/commit/161633ec94873c6262bd96ea9673717ff16c0374),
which, i believe, will not get merged into the upstream in the forseeable future

## prerequisites
* nvim 0.10 with [this patch](https://github.com/haolian9/neovim/commit/161633ec94873c6262bd96ea9673717ff16c0374)
* haolian9/infra.nvim
* haolian9/cthulhu.nvim

## usage
* `:lua require'msgcleaner'.activate()`
