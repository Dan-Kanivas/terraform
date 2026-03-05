variable "PHYO_LOCATION" {
  type = list(string)
  default = [ "Pattaya","BKK","CNX","Tak","Chinag Rai" ]
}

variable "DAN_LOCATION" {
  type = list(string)
  default = [ "CNX","BKK" ]
}

variable "COST_LIST" {
  type = list(number)
  default = [ 11,-12,59,100,-44,0 ]
}