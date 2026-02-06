// ignore_for_file: avoid_print

void main(List<String> args) {
  if (args.isEmpty) {
    printOptions();
    return;
  }

  switch (args.first) {
    case "-h":
    case "--help":
      printOptions();
      break;
  }
}

///
/// Print options
///
void printOptions() {
  print("""
--help                            : Show options
create_app --name <app_name>      : Create a new app with flutter create with structure of 
                                    sp_kit included.
                                    Ex: dart run sp_kit:create_app --name <app_name>
feature_add --name <feature_name> : Add new feature to your app.
                                    Ex: dart run sp_kit:feature_add --name <feature_name>
""");
}
