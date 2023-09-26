
/*
	为支持 手机平台的 标准数据类型定义.

*/

#ifndef _STANDDATATYPE_H_
#define _STANDDATATYPE_H_

#define _MAC

#ifndef S8
typedef char					S8;			
#endif

#ifndef U8
typedef unsigned char  			U8;			
#endif

#ifndef S16
typedef short int				S16; 		
#endif

#ifndef U16
typedef unsigned short int		U16; 		
#endif

#ifndef S32
typedef int						S32;
#endif

#ifndef U32
typedef unsigned int			U32;		
#endif

#ifndef float32
typedef float					float32;
#endif

#ifndef U64
typedef unsigned long long		U64;
#endif

#ifndef S64
typedef long long				S64;
#endif

#ifndef BYTE
typedef unsigned char			BYTE;
#endif

#ifndef DWORD
//typedef unsigned long            DWORD;
typedef int            DWORD;
#endif

#ifndef WORD
typedef unsigned short int		WORD;
#endif

#ifndef LPCSTR
typedef const char* LPCSTR ;
#endif

#endif
