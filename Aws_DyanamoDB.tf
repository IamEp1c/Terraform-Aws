resource "aws_dynamodb_table" "dynamoDbPoc" {
  name           = "dynamoDB_POC"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

# resource "aws_dynamodb_table_item" "DbTableItems" {
#   table_name = aws_dynamodb_table.dynamoDbPoc.name
#   hash_key = "id"  # Partition key: id

#   # Add the 'id' key to the item
#   item = jsonencode({
#     id    = "123"                # The partition key is 'id'
#     email = "user@example.com"
#   })
# }

resource "aws_dynamodb_table_item" "DbTableItems" {
  table_name = aws_dynamodb_table.dynamoDbPoc.name
  hash_key = "id"
  item = jsonencode({
    id    = { S = "user123" }
    userName  = { S = "slogenShade" }
    userEmail = { S = "slogenShade123@example.com" }
  })
}

# data "aws_dynamodb_table" "users" {
#  name = aws_dynamodb_table_item.DbTableItems.table_name  # Specify the name of your DynamoDB table
# }

# data "aws_dynamodb_table_item" "user_item" {
#  table_name = data.aws_dynamodb_table.users.name
#  // key = "userId"
#  // added a hashkey here 
#  key = aws_dynamodb_table_item.DbTableItems.hash_key
#   # key = <<key # expects a value of the key here
# }



