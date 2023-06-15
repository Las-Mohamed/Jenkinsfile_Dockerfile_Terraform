module "ChildResources" {
  source = "../WebServerModule"
  instance_size = "Standard_D3_v2"
  location = "westeurope"
  environment = "Prod"
}