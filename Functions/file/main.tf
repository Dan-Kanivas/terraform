locals {

  file_exists = fileexists("${path.module}/public.key.temp")

  public_key =  local.file_exists == true ? file("./public.key.temp") : "file not found"
  dir_name = dirname(path.module)
  abspath = abspath(path.root)
}
