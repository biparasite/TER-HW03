resource "local_file" "hosts_templatefile"{
 
    content = templatefile("${path.module}/hosts.tftpl",
    { webservers = yandex_compute_instance.web_servers,
      databases = yandex_compute_instance.db_vms,
      storage = yandex_compute_instance.storage  })
   filename = "${abspath(path.module)}/hosts.cfg"
}
