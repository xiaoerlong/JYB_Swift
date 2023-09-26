

#import "StandDataType.h"

#pragma  pack (push,1)


// 国内行情的基本快照(Snapshot)数据.

#define		SIZE_ITEMCODE			11			// 证券代码长度: groupcode(char) + itemcode( char[10] )
#define		SIZE_ITEMNAME			32			// 证券名长度

// pacakge头.
typedef struct tagMDPHead {
	
	int	   pkgSize ;		// 包大小( 空包: PackageSize = sizeof(MDPHead) ; )
	short  type ;			// 协议类型
	
}MDPHead ;

typedef struct tagRSAHead{
	S32		PkgSize;
	S16		type;
	S32		arraySize;
}RSAHead;


#define _MDPType_CompressPkg			100			// 压缩包
// 协议: MDPHead + CompressData.


#define _MDPTPT_PingRequest			10012	// ping

// 交易段信息
typedef struct tagTRADESESSION {
	
	U32		beginTime;			// HHMMSS
	U32		endTime;			// HHMMSS
}TRADESESSION;


#define	_MDPType_RequestItemChannel				11005		// 请求 连接/断开 item 即时更新数据的 通道.
// 协议:	REQUEST_ITEM_CHANNEL

// item channel定义.
#define _ITEM_CHANNEL_REPORT_SNAPSHOT_INTERNET		0		// 5档报价( 无BrokerSize )
#define _ITEM_CHANNEL_SLIGHT_REPORT_SNAPSHOT		1		// 1档报价( 无BrokerSize )
#define _ITEM_CHANNEL_BROKERS_LIST					2		// 经纪队列信息.
#define _ITEM_CHANNEL_REPORT_SNAPSHOT_INTERNET_EXT	3		// 5档报价扩展, 增加BrokerSize,		SMX3.10, paul, 2009-01-13, add.
#define _ITEM_CHANNEL_SLIGHT_REPORT_SNAPSHOT_EXT	4		// 1档报价扩展, 增加BrokerSize,		SMX3.10, paul, 2009-01-13, add.
#define _ITEM_CHANNEL_MARKET_STAT_INFO				5		// 市场统计信息通道(这个实际只是为 group channel做的).		SMX3.10, paul, 2009-02-23. add.

/*
 paul, 2010-10-27, 注释:
 
 因状态栏上几个指数( HSI,HIFC.... )等要求推送方式, 因此改用 最小数据的 _ITEM_CHANNEL_REPORT_0通道.
 但HIFC非常活跃, 推送量比较大, HIFC(_ITEM_CHANNEL_REPORT_0)改用 (2秒)定时推送的做法.
 */

#define _ITEM_CHANNEL_REPORT_0						6		// 0档报价( 无bid,ask信息, 无成交明细 ) clark 对应11011行情快照
#define _ITEM_CHANNEL_RADARALERT					7		// 异动雷达通道.    Danny, SMX3.60
#define _ITEM_CHANNEL_REPORT_SNAPSHOT_INTERNET_L10  8		// 10档报价.    Danny, SMX3.70  期货只会有五档订阅10档也是推送5档
#define _ITEM_CHANNEL_HANDICAP_EXT                  11       // 个股盘口扩展数 据订阅

#define _ITEM_CHANNEL_RADARABNORMAL 12 // 个股异动雷达通道. Add by Senky 2021-07-26. 使用 _MDPType_RequestItemChannel 订阅

#define _ITEM_CHANNEL_SNAPSHOT_FULL_TICK_HK_ALL_QUOTE   200 // 港股 FullTick行情数据订阅:快照(含全部买卖盘行情)
                                                            // 其订阅数据处理 与 _ITEM_CHANNEL_REPORT_SNAPSHOT_INTERNET_L10 大体相同
                                                            // 区别仅在于买卖盘报价数据 和 订阅时有全量数据推送
                                                            // 仅港股全盘行情权限支持此订阅
                                                            // 仅用名称区分全盘，方便程序查找问题
#define _ITEM_CHANNEL_FULL_TICK_HK_ORDERS               201 // 港股 FullTick行情数据订阅: 委托数据. Add by Senky 2021-05-28.
#define _ITEM_CHANNEL_FULL_TICK_HK_RADARALERT           202 // 港股 FullTick行情数据订阅: 异动雷达. Add by Senky 2021-05-28.

#define REQUEST_ITEM_CHANNEL_CONNECT		(1)
#define REQUEST_ITEM_CHANNEL_DISCONNECT		(0)

typedef struct
{
	int	   PkgSize ;		// 包大小:   sizeof(REQUEST_ITEM_CHANNEL)
	
	short  type ;			// 协议类型: type = _MDPType_RequestGroupChannel
	
	char	ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
	
	BYTE   ActionType ;		// 动作类型:  0(断开通道)/1(连接通道)
	
	int    ChannelType ;	// 通道类型:
	
	// 0:	行情快照( REPORT_SNAPSHOT_INTERNET )通道.
	// 1:	轻量级行情快照( SLIGHT_REPORT_SNAPSHOT )通道.
	// 2:	经纪队列(broker list)通道.
	
} REQUEST_ITEM_CHANNEL;


////////////////////////////////////////////
// ttframe数据 协议扩展.

// val type
#define _TTFRAME_ValType_PrvClose		0	// 昨收价
#define _TTFRAME_ValType_Open			1	// 开盘价
#define _TTFRAME_ValType_High			2	// 最高价
#define _TTFRAME_ValType_Low			3	// 最低价
#define _TTFRAME_ValType_Nominal		4	// 按盘价( 当前价 )
#define _TTFRAME_ValType_Share			5	// 股数
#define _TTFRAME_ValType_Turnover		6	// 金额
#define _TTFRAME_ValType_Bid			7	// 买盘价
#define _TTFRAME_ValType_Ask			8	// 卖盘价
#define _TTFRAME_ValType_TickCount		9	// tick数量, paul, 2009-01-14, add, SMX3.10
#define _TTFRAME_ValType_LiangBi        10  // 量比

// paul, 2009-01-14, add, SMX3.10
typedef struct
{
    DWORD   date ; 			// 日期: YYYYMMDD
    DWORD   time ; 			// 日期: HHMMSS
    char    ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
    short   ValType ;			// val类型
    int		val ;	    		// val值
} TTFRAME_DATA_INT;

typedef struct
{
    DWORD   date ; 			// 日期: YYYYMMDD
    DWORD   time ; 			// 日期: HHMMSS
    char    ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
    short   ValType ;			// val类型
    float   val ;	    		// val值
} TTFRAME_DATA_FLOAT;

typedef struct
{
    DWORD   date ; 			// 日期: YYYYMMDD
    DWORD   time ; 			// 日期: HHMMSS
    char    ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
    short   ValType ;			// val类型
    double  val ;	    		// val值
} TTFRAME_DATA_DOUBLE;

typedef struct
{
    DWORD   date ; 			// 日期: YYYYMMDD
    DWORD   time ; 			// 日期: HHMMSS
    char    ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
    float   bid ;	    		// bid值
    float   ask ;	    		// ask值
} TTFRAME_DATA_BID_ASK;

typedef struct
{
    DWORD   date ; 						// 日期: YYYYMMDD
    DWORD   time ; 						// 日期: HHMMSS
    char    ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
    float   share ;	    				// 量
    float   turnover ;	    			// 金额
} TTFRAME_DATA_SHARE_TURNOVER;

// 这个协议 客户端 可以用来计算旧的 tick数据(
typedef struct
{
    DWORD   date ; 			// 日期: YYYYMMDD
    DWORD   time ;			// 时间: HHMMSS
    char    ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
    float   nominal ;			// 按盘价
    float   share ;	    		// 总量
    float   turnover ;	    	// 总金额
} TTFRAME_DATA_LASTSNAPSHOT;

// 显示买卖1档信息.
typedef struct
{
    DWORD   date ; 			// 日期: YYYYMMDD
    DWORD   time ; 			// 日期: HHMMSS
    char    ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
    float   bid ;			// 买1价
    float   BidQunlity ;		// 买1量
    float   ask ;	    		// 卖1价
    float   AskQunlity ;		// 卖1量
} TTFRAME_DATA_BID_ASK_1;

// 美股买卖1档信息
typedef struct
{
    DWORD date; // 日期: YYYYMMDD
    DWORD time; // 日期: HHMMSS
    char ItemCode[SIZE_ITEMCODE]; // 证券代码
    float bid;        // 买1价
    float BidQunlity; // 买1量
    float ask;        // 卖1价
    float AskQunlity; // 卖1量
    char BidRPC;      // 买盘交易所代码
    char AskRPC;      // 卖盘交易所代码
} TTFRAME_DATA_BID_ASK_1_RPC;

// 显示买卖1档信息(扩展)  SMX3.10, paul, 2009-01-13, add.
typedef struct
{
    DWORD   date ; 			// 日期: YYYYMMDD
    DWORD   time ; 			// 日期: HHMMSS
    char    ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
    float   bid ;			// 买1价
    float   BidQunlity ;		// 买1量
    float   ask ;	    		// 卖1价
    float   AskQunlity ;		// 卖1量
	
	short	BidBrokerSize ;		// 买1档 经纪个数.
	short	AskBrokerSize ;		// 卖1档 经纪个数.
	
} TTFRAME_DATA_BID_ASK_1_EXT;

// 显示买卖5档信息.
typedef struct
{
    DWORD   date ; 			// 日期: YYYYMMDD
    DWORD   time ; 			// 日期: HHMMSS
    char    ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
    float   bid[5] ;			// 买1~5价
    float   BidQunlity[5] ;		// 买1~5量
    float   ask[5] ;	    		// 卖1~5价
    float   AskQunlity[5] ;		// 卖1~5量
} TTFRAME_DATA_BID_ASK_5;

// 显示买卖5档信息(扩展)  SMX3.10, paul, 2009-01-13, add.
typedef struct
{
    DWORD   date ; 			// 日期: YYYYMMDD
    DWORD   time ; 			// 日期: HHMMSS
    char    ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
    float   bid[5] ;			// 买1~5价
    float   BidQunlity[5] ;		// 买1~5量
    float   ask[5] ;	    		// 卖1~5价
    float   AskQunlity[5] ;		// 卖1~5量
	
	short	BidBrokerSize[5] ;	// 买1~5档 经纪个数.
	short	AskBrokerSize[5] ;	// 卖1~5档 经纪个数.
	
} TTFRAME_DATA_BID_ASK_5_EXT;

// 显示买卖10档信息  SMX3.70
typedef struct
{
    DWORD   date ; 			// 日期: YYYYMMDD
    DWORD   time ; 			// 日期: HHMMSS
    char    ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
    float   bid[10] ;			// 买1~10价
    float   BidQunlity[10] ;		// 买1~10量
    float   ask[10] ;	    		// 卖1~10价
    float   AskQunlity[10] ;		// 卖1~10量
	
	short	BidBrokerSize[10] ;	// 买1~10档 经纪个数.
	short	AskBrokerSize[10] ;	// 卖1~10档 经纪个数.
	
} TTFRAME_DATA_BID_ASK_10;

// 成交明细
typedef struct
{
    DWORD   date ; 			// 日期: YYYYMMDD
    WORD    time ;			// 时间: wt格式(2秒为单位)
    char    ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
	
	BYTE	type;			//类型' ' and 'Y' 需要处理
	float	price;			//价位
	DWORD	shares;			//成交量
	float	turnover;		//金额
	WORD	TTickId;		//TradeTick编号(当天的编号)
	
	// WARNING：
	// ttickId为 WORD类型已经出现overflow的现象, 这只是为了兼容以前协议(W2t/MS), 实际这个东西的价值已经弱化.
	
	///////////////////////////////////////////////////
	// QSO中定义的 tick额外信息.
	
	union
	{
		char	cInOutFlag	;			//内外盘标志
		struct
		{
			char	bInOutFlag	:4;			//内外盘标志
			char	bUpDownFlag	:4;			//涨跌标志
		} bFlag;
	} cFlag;
	
	/////////////////////////////////////////////////////
	
} TTFRAME_DATA_TRADETICK;

typedef struct
{
    DWORD   date ;             // 日期: YYYYMMDD
    WORD    time ;            // 时间: wt格式(2秒为单位)
    char    ItemCode[SIZE_ITEMCODE];    // 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
    
    BYTE    type;            //类型' ' and 'Y' 需要处理
    float    price;            //价位
    DWORD    shares;            //成交量
    float    turnover;        //金额
    WORD    TTickId;        //TradeTick编号(当天的编号)
    
    union
    {
        char    cInOutFlag    ;            //内外盘标志
        struct
        {
            char    bInOutFlag    :4;            //内外盘标志
            char    bUpDownFlag    :4;            //涨跌标志
        } bFlag;
    } cFlag;
    
    WORD wBrokerNo;        // 经纪席位号
} TTFRAME_DATA_TRADETICK_EXT;

typedef struct
{
    DWORD date ; // 日期: YYYYMMDD
    WORD time ; // 时间: wt格式(2秒为单位)
    union
    {
        char ItemCode[SIZE_ITEMCODE]; // 证券代码
        struct // 仅美股使用
        {
            char USItemCode[SIZE_ITEMCODE-1]; // 美股证券代码
            char cRPC; // Regional Part Code 交易所代码
        };
    };
    
    BYTE type; //类型' ' and 'Y' 需要处理
    float price; //价位
    DWORD shares; //成交量
    float turnover; //金额
    WORD TTickId; //TradeTick编号(当天的编号)
    
    union
    {
        char cInOutFlag ; //内外盘标志
        struct
        {
            char bInOutFlag :4; //内外盘标志
            char bUpDownFlag :4; //涨跌标志
        };
    };
    
    WORD wBrokerNo; // 经纪席位号
    
} TTFRAME_DATA_TRADETICK_US_EXT;

#define	_MDPType_TTFRAME_DATA_FLOAT				11007	 // 传送的是 TTFRAME_DATA_FLOAT
// 协议:	  MDPHead + TTFRAME_DATA_FLOAT

#define	_MDPType_TTFRAME_DATA_DOUBLE			11008	 // 传送的是 TTFRAME_DATA_DOUBLE
// 协议:	  MDPHead + TTFRAME_DATA_DOUBLE

#define	_MDPType_TTFRAME_DATA_BID_ASK			11009	 // 传送的是 TTFRAME_DATA_BID_ASK
// 协议:	  MDPHead + TTFRAME_DATA_BID_ASK

#define	_MDPType_TTFRAME_DATA_SHARE_TURNOVER	11010	 // 传送的是 TTFRAME_DATA_SHARE_TURNOVER
// 协议:	  MDPHead + TTFRAME_DATA_SHARE_TURNOVER

#define	_MDPType_TTFRAME_DATA_LASTSNAPSHOT		11011	 // 传送的是 TTFRAME_DATA_LASTSNAPSHOT
// 协议:	  MDPHead + TTFRAME_DATA_LASTSNAPSHOT

#define	_MDPType_TTFRAME_DATA_BID_ASK_1			11012	 // 传送的是 TTFRAME_DATA_BID_ASK_1
// 协议:	  MDPHead + TTFRAME_DATA_BID_ASK_1

#define	_MDPType_TTFRAME_DATA_BID_ASK_5			11013	 // 传送的是 TTFRAME_DATA_BID_ASK_5
// 协议:	  MDPHead + TTFRAME_DATA_BID_ASK_5

#define	_MDPType_TTFRAME_DATA_TRADETICK			11014	 // 传送的是 TTFRAME_DATA_TRADETICK
// 协议:	  MDPHead + TTFRAME_DATA_TRADETICK

#define	_MDPType_TTFRAME_DATA_TRADETICK_EXT		11040	 // 传送的是 TTFRAME_DATA_TRADETICK_EXT
// 协议:	  MDPHead + TTFRAME_DATA_TRADETICK_EXT

#define	_MDPType_TTFRAME_DATA_BID_ASK_10		11041	 // 传送的是 TTFRAME_DATA_BID_ASK_10
// 协议:	  MDPHead + TTFRAME_DATA_BID_ASK_10

#define	_MDPType_TTFRAME_DATA_BID_ASK_1_EXT	11021		// 传送的是 TTFRAME_DATA_BID_ASK_1_EXT( SMX3.10, paul, 2009-01-13, add. )
// 协议:	  MDPHead + TTFRAME_DATA_BID_ASK_1_EXT

#define	_MDPType_TTFRAME_DATA_BID_ASK_5_EXT	11022		// 传送的是 TTFRAME_DATA_BID_ASK_5_EXT( SMX3.10, paul, 2009-01-13, add. )
// 协议:	  MDPHead + TTFRAME_DATA_BID_ASK_5_EXT

#define	_MDPType_TTFRAME_DATA_INT			11023		// 传送的是 TTFRAME_DATA_INT( SMX3.10, paul, 2009-01-14, add. )
// 协议:	  MDPHead + TTFRAME_DATA_INT

#define	_MDPType_TTFRAME_DATA_BROKERSLIST	 11018		// 传送的是 经纪队列.
// 协议:	  MDPHead + TTFRAME_DATA_BROKERSLIST

// 经纪队列
typedef struct
{
    DWORD   date ; 			// 日期: YYYYMMDD
    WORD    time ;			// 时间: wt格式(2秒为单位)
    char    ItemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
	
	BYTE	BrokerType ;		// 1: bid / 2: ask
	short	BrokersNo[40] ;		// 经纪队列
	// BrokerNo[39]如果为 0x7fff, 显示*号, 表示有更多的 队列在后面.
} TTFRAME_DATA_BROKERSLIST;


#define	_MDPType_ResponeseLogIn				 10002		// 用户登录应答.
// 协议:	RESPONSELOGIN

// 定义 登录的返回信息.
#define	_RESPONSELOGINSTATE_Pass						0				// 通过.
#define	_RESPONSELOGINSTATE_ErrorProtocolVersion		(-1)			// error protocol version(错误的协议版本)
#define	_RESPONSELOGINSTATE_ErrorUserType				(-2)			// error user type( 错误的用户类型 )
#define	_RESPONSELOGINSTATE_ErrorUserName				(-3)			// error user name( 错误的用户名 )
#define	_RESPONSELOGINSTATE_ErrorUserPassword			(-4)			// error user password( 错误的用户密码 )
#define	_RESPONSELOGINSTATE_NoUserVerifyServer			(-5)			// no user verify server( 认证服务器不可用 )
#define	_RESPONSELOGINSTATE_NoServer					(-6)			// no server( 不能连接服务器 )
#define	_RESPONSELOGINSTATE_UserExpire					(-7)			// user expire( 账户已到期 )
#define	_RESPONSELOGINSTATE_DatabaseError				(-8)			// database error( 数据库错误 )
#define	_RESPONSELOGINSTATE_NoService					(-9)			// no service( 没有订阅相关服务 )
#define	_RESPONSELOGINSTATE_NotChinaIp					(-10)			// not china ip( 限定为 大陆ip使用, 不是大陆ip. )
#define	_RESPONSELOGINSTATE_NoFreeSubAccount			(-11)			// 没有空闲的子账号(团体账号登录使用)

// message(teletext)
#define	_MESSAGE_TELETEXT_LEN		38	/* TeleText stock page free text length	*/

typedef struct
{
    char    ItemCode[SIZE_ITEMCODE];			// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
	char	Message[_MESSAGE_TELETEXT_LEN+1] ;	// message.
	
} TTFRAME_DATA_MESSAGE_IN_TELETEXT;

#define	_MDPType_TTFRAME_DATA_MESSAGE_IN_TELETEXT				11024		// 传送的是 message(teletext)
// 协议:	  MDPHead + TTFRAME_DATA_MESSAGE_IN_TELETEXT

#define	_MDPType_EXTDATA_IN_TELETEXT				11025		// 传送的是 teletext中扩展数据部分.
// 协议:	  MDPHead + EXTDATA_IN_TELETEXT


#define	_MDPType_UAP_RequestLogInExt		11038		// 捷利通行证用户登录请求( 支持 md5加密 password )
// 协议:	REQUESTLOGIN + md5(char[32]) )
// REQUESTLOGIN.pkgSize = sizeof(REQUESTLOGIN) + 32.
// REQUESTLOGIN.type	= _MDPType_UAP_RequestLogInExt
// GUESTLOGIN.userPassword 保留字段, 这不填写 _MDPType_RequestLogIn中的 密码, 以后作为别的用途.

// md5( 源串为  sprintf( "%s%d", UserPassword, NowDate ) ;
// NowDate为 20120101.

#define	_MDPType_BUA_RequestLogIn		11039		// 券商团体账号登录请求( 不带密码 )
// 协议:	REQUESTLOGIN
// REQUESTLOGIN.pkgSize = sizeof(REQUESTLOGIN).
// REQUESTLOGIN.type	= _MDPType_BUA_RequestLogIn

typedef struct
{
    char    ItemCode[SIZE_ITEMCODE];			// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
	
	float	Avg_10 ;	// 10天平均价
	float	Avg_20 ;	// 20天平均价
	float	Avg_50 ;	// 50天平均价
	float	Avg_100 ;	// 100天平均价
	float	Avg_250 ;	// 250天平均价
	
	float	RSI_10 ;	// 10天RSI
	float	RSI_14 ;	// 14天RSI
	float	RSI_20 ;	// 20天RSI
	float	MACD_8_17 ;	// 8/17  MACD
	float	MACD_12_25 ;// 12/25 MACD
	
	float	Month1_Low ;	// 1个月波幅-最低
	float	Month1_High	;	// 1个月波幅-最高
	float	Month2_Low	;	// 2个月波幅-最低
	float	Month2_High	;	// 2个月波幅-最高
	float	Month3_Low ;	// 3个月波幅-最低
	float	Month3_High	;	// 3个月波幅-最高
	float	Week52_Low ;	// 52周波幅-最低
	float	Week52_High	;	// 52周波幅-最高
	
} EXTDATA_IN_TELETEXT;


#define	_MDPType_CmdShutdownGuest		30004		// 强制注销客户.
// 协议:	CMDSHUTDOWNGUEST

#define	_CMDSHUTDOWNGUESTREASON_UserLogInAtOtherPlace		0		// 用户在别的地方登录.
#define	_CMDSHUTDOWNGUESTREASON_ServiceOverExpireDate		1		// 服务到期或则欠费.

typedef struct tagCMDSHUTDOWNGUEST {
	
	int	   pkgSize ;		// 包大小:   sizeof(CMDSHUTDOWNGUEST)
	
	short  type ;			// 协议类型: type = _MDPType_CmdShutdownGuest
	
	char   userPassport[ 30 ] ;		// 用户名
	char   terminalType[ 20 ] ;		// 终端名
	
	int	   reason ;	// 原因:
	
	//	0:	用户在别的地方登录, 原先连接被强行关闭.
	//  1:	服务到期或则欠费.
	
}CMDSHUTDOWNGUEST ;

#define	_MDPType_Request_MDF_ServiceInfo	32001		// 查询用户的 MDF权限.
// 协议:	REQUEST_MDF_SERVICE_INFO

typedef struct tagREQUEST_MDF_SERVICE_INFO{
	
	int	   PkgSize ;		// 包大小.
	short  Type ;			// 协议类型: type = _MDPType_Request_MDF_ServiceInfo
	int	   SessionID ;		// 会话ID( 保留 )
	char   UserName[20] ;	// 用户名
	
} REQUEST_MDF_SERVICE_INFO;

#define kMaxClickCount		999999;

#define	_MDPType_Response_MDF_ServiceInfo	32002		// 应答 用户的MDF权限请求.
// 协议:	RESPONSE_MDF_SERVICE_INFO

typedef struct tagRESPONSE_MDF_SERVICE_INFO{
	
	int	   pkgSize ;		// 包大小.
	short  type ;			// 协议类型: type = _MDPType_Response_MDF_ServiceInfo
	int	   sessionID ;		// 会话ID( 保留 )
	
	char   UserName[20] ;	// 用户名
	
	BYTE   Service_Stream ;			// 串流报价服务.
	
	BYTE   Service_ClickReport ;	// 点击服务服务.
	int	   ClickCount ;				// 还允许的 点击次数.
	
} RESPONSE_MDF_SERVICE_INFO;


#define	_MDPType_RequestLogIn				 10001		// 用户登录请求.
// 协议:	REQUESTLOGIN

// login 请求桢
typedef struct tagREQUESTLOGIN {
	
	int	   pkgSize ;		// 包大小.
	
	short  type ;			// 协议类型: type = _MDPType_RequestLogIn
	
	char   userType[10] ;		// 用户类型:
	double protocolVer ;		// 协议版本:
	
	//  1. 环球快车标准版:			   "ClientSta" 或 "SMXSTD" :	0.01
	//  2. 港股大趋势决策系统:		   "ClientPro" 或 "SMMTAS" :	0.01
	//  3. 环球快车专业版:			   "SMXPRO"		:		0.01
	//  3. 远程监控者(monitor):		   "monitor"	:		0.01
	//  4. 点击报价服务(Trading):	   "Trading"	:		0.01
	
	// 2006-6-20, 协议版本改为 0.01
	
	
	char   userName[20] ;		// 用户名:
	char   userPassword[20] ;	// 用户密码:
	
}REQUESTLOGIN ;

#define	_MDPType_ResponeseLogIn				 10002		// 用户登录应答.
// 协议:	RESPONSELOGIN
/*
 // 定义 登录的返回信息.
 #define	_RESPONSELOGINSTATE_Pass						0				// 通过.
 #define	_RESPONSELOGINSTATE_ErrorProtocolVersion		(-1)			// error protocol version(错误的协议版本)
 #define	_RESPONSELOGINSTATE_ErrorUserType				(-2)			// error user type( 错误的用户类型 )
 #define	_RESPONSELOGINSTATE_ErrorUserName				(-3)			// error user name( 错误的用户名 )
 #define	_RESPONSELOGINSTATE_ErrorUserPassword			(-4)			// error user password( 错误的用户密码 )
 #define	_RESPONSELOGINSTATE_NoUserVerifyServer			(-5)			// no user verify server( 认证服务器不可用 )
 #define	_RESPONSELOGINSTATE_NoServer					(-6)			// no server( 不能连接服务器 )
 #define	_RESPONSELOGINSTATE_UserExpire					(-7)			// user expire( 帐户已到期 )
 #define	_RESPONSELOGINSTATE_DatabaseError				(-8)			// database error( 数据库错误 )
 #define	_RESPONSELOGINSTATE_NoService					(-9)			// no service( 没有订阅相关服务 )
 #define	_RESPONSELOGINSTATE_NotChinaIp					(-10)			// not china ip( 限定为 大陆ip使用, 不是大陆ip. )
 
 extern BOOL g_GetRessponseLogInInfo( int state, CString& echoInfo ) ;
 // 取认证信息.
 */
// login 应答桢
typedef struct tagRESPONSELOGIN {
	
	int	   pkgSize ;		// 包大小:   sizeof(RESPONSELOGIN)
	
	short  type ;			// 协议类型: type = _MDPType_ResponeseLogIn
	
	int	   responseState ;	// 应答状态:
	
	//	0:		pass(通过)
	//	-1:		error protocol version(错误的协议版本)
	//  -2:     error user type( 错误的用户类型 )
	//  -3:     error user name( 错误的用户名 )
	//  -4:		error user password( 错误的用户密码 )
	//  -5:		no user verify server( 认证服务器不可用 )
	//  -6:		no server( 不能连接服务器 )
	//  -7:		user expire( 帐户已到期 )
	//  -8:		database error( 数据库错误 )
	//  -9:		no service( 没有订阅相关服务 )
	//  -10:	not china ip( 限定为 大陆ip使用, 不是大陆ip. )
	
	
}RESPONSELOGIN ;


#define	_MDPType_ReportSnapshotArray		10000		// 传送的是 行情快照数组.
// 协议:	  RSAHead	  + N*REPORTSNAPSHOT
// 正文协议:  个数( int ) + N*REPORTSNAPSHOT

#define		SIZE_ITEMCODE			11			// 证券代码长度: groupcode(char) + itemcode( char[10] )
#define		SIZE_ITEMNAME			32			// 证券名长度
#define		SIZE_ITEMNAME_ALIS		8			// 证券名简称, paul, 2010-11-12, add. ( CWrapperStockAPI::GetPYCode()规定的大小 )

// 行情快照信息.
typedef struct tagREPORTSNAPSHOT{
	
	DWORD   date ;				// 日期: YYYYMMDD
	DWORD   time ;				// 时间: HHMMSS
	
	char	itemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
	char	itemName[SIZE_ITEMNAME];	// 证券名称,以'\0'结尾
	
	float	prvClose ;				// 昨收价
	float	open ;					// 今开
	float	high ;					// 最高
	float	low ;					// 最低
	float	nominal ;				// 按盘价
	float	share;					// 成交量
	float	turnover;				// 成交金额
	
	float	buyPrice[5];			// 申买价1,2,3,4,5
	float	buyVolume[5];			// 申买量1,2,3,4,5
	float	sellPrice[5];			// 申卖价1,2,3,4,5
	float	sellVolume[5];			// 申卖量1,2,3,4,5
	
} REPORTSNAPSHOT;


// 行情快照信息.
typedef struct tagREPORTSNAPSHOT_EXT{
	
	DWORD   date ;				// 日期: YYYYMMDD
	DWORD   time ;				// 时间: HHMMSS
	
	char	itemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
	char	itemName[SIZE_ITEMNAME];	// 证券名称,以'\0'结尾
	
	float	prvClose ;				// 昨收价
	float	open ;					// 今开
	float	high ;					// 最高
	float	low ;					// 最低
	float	nominal ;				// 按盘价
	float	share;					// 成交量
	float	turnover;				// 成交金额
	
	float	buyPrice[5];			// 申买价1,2,3,4,5
	float	buyVolume[5];			// 申买量1,2,3,4,5
	float	sellPrice[5];			// 申卖价1,2,3,4,5
	float	sellVolume[5];			// 申卖量1,2,3,4,5
	
	short	buyBrokersSize[5];		// 申买的经纪个数.
	short	sellBrokersSize[5];		// 申卖的经纪个数.
	
	int		tickCount ;				// 总的 tick数量.
	
} REPORTSNAPSHOT_EXT;


// 10档行情快照信息 danny, SMX3.70
typedef struct tagREPORTSNAPSHOT_L10
{
	DWORD   date ;				// 日期: YYYYMMDD
	DWORD   time ;				// 时间: HHMMSS
	
	char	itemCode[SIZE_ITEMCODE];	// 证券代码,以'\0'结尾( groupcode(char)+itemcode( char[10] ) )
	char	itemName[SIZE_ITEMNAME];	// 证券名称,以'\0'结尾
	
	float	prvClose ;				// 昨收价
	float	open ;					// 今开
	float	high ;					// 最高
	float	low ;					// 最低
	float	nominal ;				// 按盘价
	float	share;					// 成交量
	float	turnover;				// 成交金额
	
	float	buyPrice[10];			// 申买价1,2,3,4,5
	float	buyVolume[10];			// 申买量1,2,3,4,5
	float	sellPrice[10];			// 申卖价1,2,3,4,5
	float	sellVolume[10];			// 申卖量1,2,3,4,5
	
	short   buyBrokerSize[10] ;		// 申买5档 经纪个数
	short   sellBrokerSize[10] ;		// 申卖5档 经纪个数
	
	int		TickCount ;				// 总的tick数量.
	
} REPORTSNAPSHOT_L10;

// 科创板盘后行情快照数据
typedef struct tagSnapshotAfterHourTradeInfo
{
    DWORD   date;                // 日期: YYYYMMDD
    DWORD   time;                // 时间: HHMMSS
    char    itemCode[SIZE_ITEMCODE]; // 证券代码
    char    status;                 // 证券状态:
    // 'I'表示启动（开市前）
    // 'A'表示集中撮合时段
    // 'H'表示连续交易时段
    // 'D'表示闭市时段
    // 'F'表示停牌
    
    float    price;                    // 固定价
    float    share;                    // 成交量
    float    turnover;                // 成交金额
    float    buyVolume;                // 申买量
    float    sellVolume;                // 申卖量
}stSnapshotAfterHourTradeInfo;

//科创板相关协议
#define    _MDPTYPE_TTFRAME_DATA_LASTSNAPSHOT_AFTERHOURTRADE    11073 //科创板盘后数据推送
#define    _ITEMSDATATYPE_SNAPSHOTAFTERHOURTRADE     26   //科创板盘后行情数据请求
#define    _MDPType_SnapshotAfterHourTradeInfoList        10095   //科创板盘后行情快照数据应答

#define	_MDPType_RequestItemsData		 10006		// 请求 item数据.
// 协议:	REQUESTITEMSDATAHEAD + N*itemcode( string )

#define	_ITEMSDATATYPE_REPORTSNAPSHOT			 0			// 行情快照( REPORTSNAPSHOT )
#define	_ITEMSDATATYPE_REPORTSNAPSHOT_EXT		 7			// 行情快照扩展( REPORTSNAPSHOT_EXT )
#define	_ITEMSDATATYPE_MESSAGE_IN_TELETXT		 8			// message(teletext), paul, 2009-02-26 add, SMX3.10
#define	_ITEMSDATATYPE_EXTDATA_IN_TELETXT		 9			// teletxt中扩展数据( 技术指标数据 ), paul, 2009-02-26 add, SMX3.10
#define	_ITEMSDATATYPE_REPORTSNAPSHOT_L10		 11			// 10档行情快照( REPORTSNAPSHOT_L10 ), Danny, 2011-10-21 add, SMX3.70

// 请求items数据的头.
typedef struct tagREQUESTITEMSDATAHEAD {
	
	int	   pkgSize  ;		// 包大小.
	
	short  type ;			// 协议类型
	
	int    dataType ;		// 数据类型:
	
	// _ITEMSDATATYPE_***
	
	int    itemsSize ;		// item个数
	
} REQUESTITEMSDATAHEAD ;

#define    _MDPType_ReportSnapshotExtArray        11020        // 传送的是 行情快照(扩展)数组.  paul, 2009-01-14 add, SMX3.10
// 协议:      RSAHead      + N*REPORTSNAPSHOT_EXT
// 正文协议:  个数( int ) + N*REPORTSNAPSHOT_EXT

#define	_MDPType_ReportSnapshotL10Array		11037		// 传送的是 10档行情快照数组.
// 协议:	  RSAHead	  + N*REPORTSNAPSHOT_L10
// 正文协议:  个数( int ) + N*REPORTSNAPSHOT_EXT

#define	_MDPType_MF_QueryMarket				12015
// 查询: 市场即时资金流向 分类统计: MDPHead
#define	_MDPType_MF_ResponseMarket			12016
// 应答: MDPHead + MONEYFLOW_MARKET

typedef struct tagMONEYFLOW_MARKET {
	short nStock_Inflow_Count;		// 股票. 流入家数
	float fStock_Inflow_Amount;		// 股票. 流入金额
	short nStock_Outflow_Count;		// 股票. 流出家数
	float fStock_Outflow_Amount;	// 股票. 流出金额
	
	short nCall_Inflow_Count;	// 认购
	float fCall_Inflow_Amount;
	short nCall_Outflow_Count;
	float fCall_Outflow_Amount;
	
	short nPut_Inflow_Count;	// 认沽
	float fPut_Inflow_Amount;
	short nPut_Outflow_Count;
	float fPut_Outflow_Amount;
	
	short nBull_Inflow_Count;	// 牛证
	float fBull_Inflow_Amount;
	short nBull_Outflow_Count;
	float fBull_Outflow_Amount;
	
	short nBear_Inflow_Count;	// 熊证
	float fBear_Inflow_Amount;
	short nBear_Outflow_Count;
	float fBear_Outflow_Amount;
}MONEYFLOW_MARKET ;

#define    _MDPType_TradingClient_RequestLogIn_NoPassowrd        32006        // 点击报价客户的免密码登录.
// 协议:    REQUESTLOGIN( userType="Trading" )


//1.4.1 新登记接口
//请求： // 协议：OnlineStateExt
#define    _MDPType_RequestRegisterOnlineState   11082
//响应： // 预留未响应给终端
#define    _MDPType_ResponseRegisterOnlineState   11083


//1.4.2 互踢 // 协议：KickCommandExt
#define     _MDPType_KickGuestCommand  11084


/*
 // 登记
 // 用户的 (ip:port).
 // 用户ID // org + . + 交易账号
 // 用户ID类型 0:txz[通行证账号] 1:qq 2:wb 3:mobile 4:wx 5:fb 6:unuse7:uid[通行证id] 8:trade 9:2601[行情账号] 10:tftrade[期货交易账号]
 //终端名 :mac：ClientMac， PC：SMXPRO，手机：Moblie，
 // 交易：Trading，NBS：SMXNBS
 // 终端版本号
  // uap session[for web terminal]
 */

typedef struct _tagGuestDetail {
    char szIP[30];
    char szUserID[64];
    short usrType;
    char terType[20];
    char terVersion[20];
    char szSession[48];
} GuestDetail;

/*
  int    pkgSize;                // 包大小:   sizeof(OnlineStateExt)
  short  type;                  // 协议类型: type = _MDPType_RequestRegisterOnlineState
  int    sessionID;               // 会话ID.
  short  state;                  // 0 登出 1 登录
  GuestDetail detail;
  char   orgID[8];               // 机构号: 如TTT
 unsigned char mobileSystemID;   // 手机端系统ID (仅客户端有效) 1.ios 2.android
 */


typedef struct _tagOnlineStateExt {
    int  pkgSize;
    short type;
    int sessionID;
    short state;
    GuestDetail detail;
    char orgID[8];
    unsigned char mobileSystemID;
    char szReserved[51];
    
}OnlineStateExt;


/*
 int       pkgSize;        // 包大小:   sizeof(RespOnlineStateExt)
 short     type;            // 协议类型: type = _MDPType_ResponseRegisterOnlineState
 int       sessionID;                    // 会话ID.
 int       state;                        // 0 成功 1 失败
 */
// 登记的响应
typedef struct _tagRespOnlineStateExt {
    
    int       pkgSize;        // 包大小:   sizeof(RespOnlineStateExt)
    short     type;            // 协议类型: type = _MDPType_ResponseRegisterOnlineState
    int       sessionID;                    // 会话ID.
    int       state;                        // 0 成功 1 失败
    
}RespOnlineStateExt;



/*
 int   pkgSize;                     // 包大小:   sizeof(KickCommandExt)
 short type;                       // 协议类型: type = _MDPType_KickGuestCommand
 GuestDetail datail_1;             // T出者的详细信息
 GuestDetail datail_2;            // 被T出者的详细信息
 short  reason;                  // 原因:0 别处登录， 4 用户主动注销（如打开两个标签页，在一个标签页注销，另一个标签页也会注销），5 用户已被切换到延迟FDS
 int identify;                     // 文档写的是id
 */
// 踢出
typedef struct tagKickCommandExt {
    int             pkgSize;
    short           type;
    GuestDetail     datail_1;
    GuestDetail     datail_2;
    short           reason;
    int             identify;
}KickCommandExt;


#pragma pack(pop) 
