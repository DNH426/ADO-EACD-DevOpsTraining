# --------------------------------------------------------
# Cognito setup for user management
# --------------------------------------------------------
resource "aws_cognito_user_pool" "dnh_pool" {
  name                            = var.cognito-user-pool-name
  # auto_verified_attributes        = ["email"]
  # email_verification_subject      = "Confirmation email code for Wild Rydes application"

  tags = local.tags
}

# --------------------------------------------------------
# Create App Client in the pool
# --------------------------------------------------------
resource "aws_cognito_user_pool_client" "dnh_pool_client" {
  name                            = var.cognito-user-pool-client
  user_pool_id                    = aws_cognito_user_pool.dnh_pool.id
  # generate_secret                 = false
  
}