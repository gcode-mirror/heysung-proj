#import "DLL_loglib.dll"

#define		FATAL_HEY		1
#define		ERROR_HEY		2
#define		WARN_HEY		3
#define		INFO_HEY		4
#define		DEBUG_HEY		5

#define		LOG2STDOUT		1
#define		LOG2FILE		2
#define		ALL				3


void   log_file(string dbg_buf);
void   Dbgout(int logout,int level,string  fmt, ...);
void   init_log(int  level,int logout);