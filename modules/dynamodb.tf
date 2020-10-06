# --------------------------------------------------------
# Table to record user requests for a unicorn
# --------------------------------------------------------
resource "aws_dynamodb_table" "dnh-rides" { 
  name           = "dnh_Rides" 
  hash_key       = "RideId"
  billing_mode   = "PAY_PER_REQUEST" 

  attribute {
    name = "RideId"
    type = "S"
  }

  tags = local.tags
}