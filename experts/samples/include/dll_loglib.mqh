#import "ExpertSample.dll"
 void  log_file(char * dbg_buf);

void Dbgout(LOGOUT logout,LogLevel level,char * fmt, ...);
void  init_log(LogLevel  level,LOGOUT logout);