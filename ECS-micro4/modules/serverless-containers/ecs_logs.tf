resource "aws_cloudwatch_log_group" "ms_nodeapps_log_group" {
    name                  = "${var.loggroupname}"
    retention_in_days     = "30"
    tags = {
        Name = "nodeapps_cont_loggroup"
    }
}

/* ## Below log streams are not actually used - it is hardcoded with prefix ecs in apps json file.
## If needed to have separate log steam, use variables and substitute with this.
resource "aws_cloudwatch_log_stream" "ms_nodeapps_log_stream" {
    name                = "nodeapp1_log_stream"
    log_group_name      = "${aws_cloudwatch_log_group.ms_nodeapps_log_group.name}"
}
resource "aws_cloudwatch_log_stream" "ms_nodeapps2_log_stream" {
    name                = "nodeapp2_log_stream"
    log_group_name      = "${aws_cloudwatch_log_group.ms_nodeapps_log_group.name}"
}
*/
