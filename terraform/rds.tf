/* 既存のrdsをインポート */
resource "aws_db_instance" "kb-db" {
  instance_class                        = "db.t2.micro"
  max_allocated_storage                 = 21 
  copy_tags_to_snapshot                 = true
  skip_final_snapshot                   = true 
  publicly_accessible                   = true
}