#import "ExpertSample.dll"

typedef enum {FATAL_HEY,ERROR_HEY, WARN_HEY,INFO_HEY,DEBUG_HEY}LogLevel;
typedef enum {LOG2STDOUT,LOG2FILE,ALL}LOGOUT;

void  log_file(char * dbg_buf);
void Dbgout(LOGOUT logout,LogLevel level,char * fmt, ...);
void  init_log(LogLevel  level,LOGOUT logout);


