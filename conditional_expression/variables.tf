
variable "ingress_rules" {
  description = "List of ingress rules for security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH"
    }
  ]
}

variable "environment" {
  description = "Environment name (dev or prod)"
  type        = string
  default     = "dev"
}


# variable "testing" {
#   type = list(string)
#   default = ["testing1","testing2","testing3"]
# }

variable "object-var" {
  type = object({
    Name = string
    Age = number
  })
  default = {
    Name = "John"
    Age = 30
  }
}
