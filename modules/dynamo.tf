resource "aws_dynamodb_table" "Rides" { 
  name           = "${var.env}_Rides" 
  billing_mode   = "PAY_PER_REQUEST" 

  attribute {
    name = "RideId"
    type = "S"
  }

  tags = local.tags

}