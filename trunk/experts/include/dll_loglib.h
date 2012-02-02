#define _DEBUG_VERSION

 typedef enum {FATAL_HEY,ERROR_HEY, WARN_HEY,INFO_HEY,DEBUG_HEY}LogLevel;

typedef enum {LOG2STDOUT,LOG2FILE,ALL}LOGOUT;

__declspec(dllexport) void  __stdcall log_file(char * dbg_buf);

__declspec(dllexport) void __stdcall  Dbgout(LOGOUT logout,LogLevel level,char * fmt, ...);
__declspec(dllexport) void  __stdcall init_log(LogLevel  level,LOGOUT logout);