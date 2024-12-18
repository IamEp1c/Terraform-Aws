# resource "aws_amplify_app" "example" {
#   name       = "ServerLessApp"
#   repository = "https://github.com/example/serverlessApp"

#   # The default build_spec added by the Amplify Console for React.
#   build_spec = <<-EOT
#     version: 0.1
#     frontend:
#       phases:
#         preBuild:
#           commands:
#             - yarn install
#         build:
#           commands:
#             - yarn run build
#       artifacts:
#         baseDirectory: build
#         files:
#           - '**/*'
#       cache:
#         paths:
#           - node_modules/**/*
#   EOT

#   # The default rewrites and redirects added by the Amplify Console.
#   custom_rule {
#     source = "/<*>"
#     status = "404"
#     target = "/index.html"
#   }

#   environment_variables = {
#     ENV = "test"
#   }
# }