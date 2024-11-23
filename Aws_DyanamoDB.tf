resource "aws_dynamodb_table" "dynamoDbPoc" {
  name             = "dynamoDBPOC"
  hash_key         = "TestTableHashKey"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "TestTableHashKey"
    type = "S"
  }

  replica {
    region_name = "us-east-2"
  }

#   replica {
#     region_name = "us-west-2"
#   }
}

resource "aws_dynamodb_table_item" "DbTableItems" {
  table_name = aws_dynamodb_table.dynamoDbPoc.name
  hash_key = "userId"
item = jsonencode({
    userId    = { S = "user123" }
    userName  = { S = "slogenShade" }
    userEmail = { S = "slogenShade123@example.com" }
  })
}

data "aws_dynamodb_table" "users" {
 name = aws_dynamodb_table_item.DbTableItems.table_name  # Specify the name of your DynamoDB table
}

data "aws_dynamodb_table_item" "user_item" {
 table_name = data.aws_dynamodb_table.users.name
 // key = "userId"
 // added a hashkey here 
 key = aws_dynamodb_table_item.DbTableItems.hash_key
  # key = <<key # expects a value of the key here
}



