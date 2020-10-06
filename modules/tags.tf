# --------------------------------------------------------
# Global Tags
# --------------------------------------------------------
locals { 
    tags = {
        Application = var.app-name
        Environment = var.env
    }
} 