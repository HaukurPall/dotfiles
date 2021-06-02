# Source bash files and export to fish
function bass
  exec bash -c "source $argv; exec fish"
end