
/*
 行情标准协议 -- 给 CMS(交易服务器)用的部分
 
 [31000,31800)
 
 IPO 协议用 [31501~315099] // willy Add 2009-09-09
 
 */

#ifndef _MARKETDATAPROTOCOL_CMS_H_
#define _MARKETDATAPROTOCOL_CMS_H_

#include "MarketDataProtocol.h"

#pragma  pack (push,1)

#define MDPType_CMS_ClientRequest_Holding		21000	//资金股份 (tanson 2012.01.31 兴业)

#define	_MDPType_CMS_ClientRequest_LogOn		 31000			//	客户请求登录协议
// CMS_CLIENT_REQUEST_LOGON

// 交易客户 logon 请求桢
struct CMS_CLIENT_REQUEST_LOGON 
{
	
	int	   PkgSize ;		// 包大小.
	
	short  Type ;			// 协议类型: type = _MDPType_CMS_ClientLogOn
	
	char   ClientExeType[10] ;		// 客户软件类型:
	double ProtocolVer ;			// 协议版本:  	
	
	//  1. 交易软件:					"Trading" :		0.01
	
	char   UserName[20] ;		// 用户名:
	char   UserPassword[20] ;	// 用户密码:
	short  LogInType ;			// 客户类型(  client account/web AE )        
	
	int    LangType ;			// 语言类型: ( 英文(0)/简体中文(1)/繁体中文(2) )
	
} ;

// 交易客户 logon 请求桢中金 CIC
struct CMS_CLIENT_REQUEST_LOGON_EXT_CIC
{
    
    int	   PkgSize ;		// 包大小.
    
    short  Type ;			// 协议类型: type = _MDPType_CMS_ClientLogOn
    
    char   ClientExeType[10] ;		// 客户软件类型:
    double ProtocolVer ;			// 协议版本:
    
    //  1. 交易软件:					"Trading" :		0.01
    
    char   UserName[24] ;		// 用户名:
    char   UserPassword[24] ;	// 用户密码:
    short  LogInType ;			// 客户类型(  client account/web AE )
    
    int    LangType ;			// 语言类型: ( 英文(0)/简体中文(1)/繁体中文(2) )
    
} ;
// 交易客户 logon 请求桢
struct CMS_CLIENT_REQUEST_LOGON_EXT_NEW
{
    
    int	   PkgSize ;		// 包大小.
    
    short  Type ;			// 协议类型: type = _MDPType_CMS_ClientLogOn
    
    char   ClientExeType[10] ;		// 客户软件类型:
    double ProtocolVer ;			// 协议版本:
    
    //  1. 交易软件:					"Trading" :		0.01
    
    char   UserName[20] ;		// 用户名:
    char   UserPassword[20] ;	// 用户密码:
    short  LogInType ;			// 客户类型(  client account/web AE )
    
    int    LangType ;			// 语言类型: ( 英文(0)/简体中文(1)/繁体中文(2) )
    
    char   szClientIP[20];      //
    char   szTradeChannel[20];  // 
    
} ;

struct CMS_CLIENT_REQUEST_LOGON_EXT_AND_MAC
{
    
    int	   PkgSize ;		// 包大小.
    short  Type ;			// 协议类型: type = _MDPType_CMS_ClientLogOn
    char   ClientExeType[10] ;		// 客户软件类型:
    double ProtocolVer ;			// 协议版本:
    char   UserName[20] ;		// 用户名:
    char   UserPassword[20] ;	// 用户密码:
    short  LogInType ;			// 客户类型(  client account/web AE )
    
    int    LangType ;			// 语言类型: ( 英文(0)/简体中文(1)/繁体中文(2) )
    char   szClientIP[20] ;		// 用户名:
    char   szTradeChannel[20];   // 终端类型：（交银的 PC->D    MOBILE->M    ）
    char   szMacAddress[40];    // Client 端mac 地址：
    
} ;

struct CMS_CLIENT_REQUEST_LOGON_EXT_AND_MAC_GATEWAY_VESION
{
    
    int          PkgSize ;              // 包大小.
    
    short  Type ;                     // 协议类型: type = _MDPType_CMS_ClientLogOn
    
    char   ClientExeType[10] ;              // 客户软件类型:
    double ProtocolVer ;                     // 协议版本:
    
    //  1. 交易软件:                                   "Trading" :              0.01
    
    char   UserName[20] ;              // 用户名:
    char   UserPassword[20] ;       // 用户密码:
    short  LogInType ;                     // 客户类型(  client account/web AE )
    
    int    LangType ;                     // 语言类型: ( 英文(0)/简体中文(1)/繁体中文(2) )
    
    char   szClientIP[20] ;              // 用户名:
    char   szTradeChannel[20];   // 终端类型：（交银的 PC->D    MOBILE->M    ）
    char   szMacAddress[40];    // Client 端mac 地址：
    char   sziGatewayVesion[20]; // 柜台iGateway 版本
} ;
//交银登录结构修改
struct CMS_CLIENT_REQUEST_LOGON_EXT_AND_MAC_GATEWAY_VESION_CLIENT
{
    
    int       PkgSize ;        // 包大小.
    
    short  Type ;            // 协议类型: type = _MDPType_CMS_ClientLogOn
    
    char   ClientExeType[10] ;        // 客户软件类型:
    double ProtocolVer ;            // 协议版本:
    
    //  1. 交易软件:                    "Trading" :        0.01
    
    char   UserName[20] ;        // 用户名:
    char   UserPassword[20] ;    // 用户密码:
    short  LogInType ;            // 客户类型(  client account/web AE )
    
    int    LangType ;            // 语言类型: ( 英文(0)/简体中文(1)/繁体中文(2) )
    
    char   szClientIP[20] ;        // 用户名:
    char   szTradeChannel[20];   // 终端类型：（交银的 PC->D    MOBILE->M    ）
    char   szMacAddress[40];    // Client 端mac 地址：
    char   sziGatewayVesion[20]; // 柜台iGateway 版本
    char   szClientVer[20];        //客户端版本
} ;


struct CMS_CLIENT_REQUEST_LOGON_EXT_AND_MAC_AYERS_VERSION
{
    
    int    PkgSize ;  // 包大小.
    
    short  Type ;   // 协议类型: type = _MDPType_CMS_ClientLogOn
    
    char   ClientExeType[10] ;  // 客户软件类型:
    double ProtocolVer ;   // 协议版本:
    
    //  1. 交易软件:     "Trading" :  0.01
    
    char   UserName[20] ;  // 用户名:
    char   UserPassword[20] ; // 用户密码:
    short  LogInType ;   // 客户类型(  client account/web AE )
    
    int    LangType ;   // 语言类型: ( 英文(0)/简体中文(1)/繁体中文(2) )
    
    char   szClientIP[20] ;  // 用户名:
    char   szTradeChannel[20];   // 终端类型：（交银的 PC->D    MOBILE->M    ）
    char   szMacAddress[40];    // Client 端mac 地址：
    char   szClientVersion[20];  // 客户端版本号  针对中金ios提示客户升级问题 add by victor 2018-04-09
} ;

struct CMS_CLIENT_REQUEST_LOGON_EXT_AND_MAC_AYERS_VERSION_MODEL
{
    
    int       PkgSize ;        // 包大小.
    
    short  Type ;            // 协议类型: type = _MDPType_CMS_ClientLogOn
    
    char   ClientExeType[10] ;        // 客户软件类型:
    double ProtocolVer ;            // 协议版本:
    
    //  1. 交易软件:                    "Trading" :        0.01
    
    char   UserName[20] ;         // 用户名:
    char   UserPassword[20] ;     // 用户密码:
    short  LogInType ;             // 客户类型(  client account/web AE )
    
    int    LangType ;             // 语言类型: ( 英文(0)/简体中文(1)/繁体中文(2) )
    
    char   szClientIP[20] ;         // 用户名:
    char   szTradeChannel[20];   // 终端类型：（交银的 PC->D    MOBILE->M    ）
    char   szMacAddress[40];     // Client 端mac 地址：
    char   szClientVersion[20];     // 终端版本，原来的字段
    char   szphoneModel[40];     // 手机型号，新增的字段
} ;

struct CMS_CLIENT_REQUEST_LOGON_CPY
{
    
    
    int       PkgSize ;        // 包大小.
    short  Type ;            // 协议类型: type = _MDPType_CMS_ClientLogOn
    char   ClientExeType[10] ;        // 客户软件类型:
    double ProtocolVer ;            // 协议版本:
    char   UserName[20] ;        // 用户名:
    char   UserPassword[50] ;    // 用户密码:
    short  LogInType ;            // 客户类型(  client account/web AE )
    
    int    LangType ;            // 语言类型: ( 英文(0)/简体中文(1)/繁体中文(2) )
    char   szClientIP[20] ;        // 用户名:
    char   szTradeChannel[20];   // 终端类型：（交银的 PC->D    MOBILE->M    ）
    char   szMacAddress[40];    // Client 端mac 地址：
    int    version;      //1 新版本
} ;

// 交易客户 logon 请求桢兴证专业版 INDL
struct CMS_CLIENT_REQUEST_LOGON_EXT_AND_MACDEVICE
{
    
    int       PkgSize ;        // 包大小.
    short  Type ;            // 协议类型: type = _MDPType_CMS_ClientLogOn
    char   ClientExeType[10] ;        // 客户软件类型:
    double ProtocolVer ;            // 协议版本:
    char   UserName[20] ;        // 用户名:
    char   UserPassword[20] ;    // 用户密码:
    short  LogInType ;            // 客户类型(  client account/web AE )
    
    int    LangType ;            // 语言类型: ( 英文(0)/简体中文(1)/繁体中文(2) )
    char   szClientIP[20] ;        // 用户名:
    char   szTradeChannel[20];   // 终端类型：（交银的 PC->D    MOBILE->M    ）
    char   szMacAddress[40];    // Client 端mac 地址：
    char   szDeviceID[50];      //device id  IDFV
    char   szDeviceName[30];       // deveice name 具体型号
} ;

struct CMS_CLIENT_REQUEST_LOGON_EXT_AND_MAC_GATEWAY_VESION_CLIENT_OTP
{
    
    int     PkgSize ;    // 包大小.
    
    short  Type ;      // 协议类型: type = _MDPType_CMS_ClientLogOn
    
    char   ClientExeType[10] ;    // 客户软件类型:
    double ProtocolVer ;      // 协议版本:
    
    //  1. 交易软件:          "Trading" :    0.01
    
    char   UserName[20] ;    // 用户名:
    char   UserPassword[20] ;  // 用户密码:
    short  LogInType ;      // 客户类型(  client account/web AE )
    
    int    LangType ;      // 语言类型: ( 英文(0)/简体中文(1)/繁体中文(2) )
    
    char   szClientIP[20] ;    // 用户名:
    char   szTradeChannel[20];   // 终端类型：（交银的 PC->D    MOBILE->M    ）
    char   szMacAddress[40];    // Client 端mac 地址：
    char   sziGatewayVesion[20]; // 柜台iGateway 版本
    char   szClientVer[20];    //客户端版本
    char   szDeviceID[50];    // device id
    char   szDeviceName[30];    // deveice name
} ;

// 交易客户 logon 请求桢兴证专业版 INDL
struct CMS_CLIENT_REQUEST_LOGON_EXT_AND_MACDEVICE_TAH
{
    
    int       PkgSize ;        // 包大小.
    short  Type ;            // 协议类型: type = _MDPType_CMS_ClientLogOn
    char   ClientExeType[10] ;        // 客户软件类型:
    double ProtocolVer ;            // 协议版本:
    char   UserName[20] ;        // 用户名:
    char   UserPassword[20] ;    // 用户密码:
    short  LogInType ;            // 客户类型(  client account/web AE )
    
    int    LangType ;            // 语言类型: ( 英文(0)/简体中文(1)/繁体中文(2) )
    char   szClientIP[20] ;        // 用户名:
    char   szTradeChannel[20];   // 终端类型：（交银的 PC->D    MOBILE->M    ）
    char   szMacAddress[40];    // Client 端mac 地址：
    char   szDeviceID[50];      //device id  IDFV
    char   szDeviceName[30];       // deveice name 具体型号
    char   sziGatewayVesion[20]; // 柜台iGateway 版本
} ;
#define	_MDPType_CMS_ServerResponse_ClientLogon_Faile		31001		//	对客户登录失败应答
// CMS_SERVER_RESPONSE_CLIENT_LOGON_HEAD
    
struct CMS_SERVER_RESPONSE_CLIENT_LOGON_HEAD
{
	
	int	   PkgSize ;		// 包大小.
	short  Type ;			// 协议类型: type = _MDPType_CMS_ClientLogonResponse
	int	   Status ;			// 认证状态:
	
} ;
/// ayers柜台的密码过期提示
#define _MDPType_CMS_ClientPwdExpire                        31036
/// AYERS柜台的密码过期提示
struct CMS_SERVER_RESPONSE_CLIENT_PWD_EXPIRE
{
    int    PkgSize ;                // 包大小.
    short  Type ;                    // 协议类型: type = _MDPType_CMS_ClientLogonResponse
    BOOL   bIsNotice;                // 是否提示
    int    expireTime;                // 过期时间
} ;
struct CMS_SERVER_RESPONSE_CLIENT_SESSION
{
    int    PkgSize ;    // 包大小.
    short  Type ;     // 协议类型:
    char   Session[100] ;   // Session
} ;

#define _MDPType_CMS_ClientRequest_Session_LogOn   31052
#define _MDPType_CMS_ClientResponse_Session_LogOn   31053

#define	_MDPType_CMS_ServerResponse_ClientLogon_Pass		31002		//	对客户登录成功应答
// CMS_SERVER_RESPONSE_CLIENT_LOGON_HEAD + CMS_SERVER_RESPONSE_CLIENT_LOGON_OK_DATA

struct CMS_SERVER_RESPONSE_CLIENT_LOGON_OK_DATA
{
	// 正确登录后信息:
	
	int    MDF_Type ;			// mdf类型	
	
	char   MDF_UserName[20] ;		// mdf系统的 用户名.
	char   MDF_UserPassword[20] ;	// mdf系统的 用户密码.
	
	int	   LastLogonDate ;		//	最后登录日期: YYMMDD
	int	   LastLogonTime ;		//	最后登录时间: hhmmss
	
	char   AccountID[20] ;		//  账户ID.
	
} ;

///iAsia 2FA 二阶段协议拓展(API 1.81.1)
struct CMS_SERVER_RESPONSE_CLIENT_2ND_LOGON_OK_DATA_IAISA_SESSION
{
    // 正确登录后信息:
    
    int    MDF_Type ;            // mdf类型
    
    char   MDF_UserName[20] ;        // mdf系统的 用户名.
    char   MDF_UserPassword[20] ;    // mdf系统的 用户密码.
    
    int       LastLogonDate ;        //    最后登录日期: YYMMDD
    int       LastLogonTime ;        //    最后登录时间: hhmmss
    
    char   AccountID[20] ;        //  帐户ID.
    
    int       ITS_Date ;            //  iTrading server 当前日期， YYMMDD
    
    
    char   second_pwd_hints[20]; // 增加二次登录返回的提示编码
    char   RandomData[20];       // 初次登录应答返回的随机数字
    
    char   LastChangePSWDate[20]; // 上次修改密码的时间
    char   RemainingDate[20];     // 密码有效期剩余时间
    char   AlertChangePassWord[20]; // 是否需密码有效日的提醒，是否需强制修改密码
    char   szSession[100];
} ;

//CPY 登陆返回协议添加了账户类型改用。 CMS_SERVER_RESPONSE_CLIENT_LOGON_OK_DATA_EXT_ACTYPE
struct CMS_SERVER_RESPONSE_CLIENT_LOGON_OK_DATA_EXT_ACTYPE
{
    // 正确登录后信息:
    
    int    MDF_Type ;   // mdf类型
    
    char   MDF_UserName[20] ;  // mdf系统的 用户名.
    char   MDF_UserPassword[20] ; // mdf系统的 用户密码.
    
    int    LastLogonDate ;  // 最后登录日期: YYMMDD
    int    LastLogonTime ;  // 最后登录时间: hhmmss
    
    char   AccountID[20] ;  //  帐户ID.
    
    char   AccType[4];   //  账户类型
    
} ;
//CPY 二重登陆返回协议
struct CMS_SERVER_RESPONSE_CLIENT_2ND_LOGON_OK_DATA_EXT
{
    // 正确登录后信息:
    
    int    MDF_Type ;   // mdf类型
    
    char   MDF_UserName[20] ;  // mdf系统的 用户名.
    char   MDF_UserPassword[20] ; // mdf系统的 用户密码.
    
    int    LastLogonDate ;  // 最后登录日期: YYMMDD
    int    LastLogonTime ;  // 最后登录时间: hhmmss
    
    char   AccountID[20] ;  //  帐户ID.
    char   AccType[4];   //  账户类型
    int    ITS_Date ;   //  iTrading server 当前日期， YYMMDD
    
    
    char   second_pwd_hints[20]; // 增加二次登录返回的提示编码
    char   RandomData[20];       // 初次登录应答返回的随机数字
    char   szURL[256];
    
    bool  m_alert_change_pwd ;
    bool  m_force_change_pwd ;
    char  m_pwd_expiry_date[24] ;
    bool  m_remind_change_pwd;
    
    bool m_bNeedPrompt;
    char m_sszActionMessage[255];
    char m_szPopupUrl[255];
} ;
//CSS x安信登录结构包
struct AFE_CMS_CLIENT_REQUEST_LOGON_TRADEGO
{
    char   ClientExeType[10] ;  // 客户软件类型:
    double ProtocolVer ;   // 协议版本:
    
    //  1. 交易软件:     "Trading" :  0.01
    
    char   UserName[20] ;  // 用户名:
    char   UserPassword[20] ; // 用户密码:
    int    LangType ;   // 语言类型: ( 英文(0)/简体中文(1)/繁体中文(2) )
    
    char   MacAddress[50]; // mac地址
    char   ClientIP[20];//客户端IP；
    char   ChannelType[10];
    
    char   clientID[20]; // 账户ID
    char   acctType[10]; // 账户类型
    char   sessionID[30]; // 有效会话
    
    char   szDeviceID[50]; // device id
    char   szDeviceName[50];// deveice name
    
} ;


 struct CMS_SERVER_RESPONSE_CLIENT_LOGON_OK_DATA_EXT
 {
 // 正确登录后信息:
 
 int    MDF_Type ;			// mdf类型
 
 char   MDF_UserName[20] ;		// mdf系统的 用户名.
 char   MDF_UserPassword[20] ;	// mdf系统的 用户密码.
 
 int	   LastLogonDate ;		//	最后登录日期: YYMMDD
 int	   LastLogonTime ;		//	最后登录时间: hhmmss
 
 char   AccountID[20] ;		//  帐户ID.
 
 int    AccountType;    //团体账号类型
 
 };

#define	_MDPType_CMS_ServerNotify_Message		31003		//	server端 通知client的信息.
// CMS_SERVER_NOTIFY_MESSAGE + string( size(short)+char[] )

// 定义通知的消息类型.
#define _SNM_TYPE_PRECHECK_PACKAGE_ERROR		(-10)	// 下单信息错误.
#define _SNM_TYPE_CHANGE_PASSWORD_PACKAGE_ERROR	(-9)	// 修改密码信息错误.
#define _SNM_TYPE_ORDER_REQUEST_PACKAGE_ERROR	(-8)	// 下单信息错误.
#define _SNM_TYPE_BACKGROUND_SERVER_NOT_READDY	(-7)	// 后台服务器不可用.
#define _SNM_TYPE_NOT_SUPPORT_SOFTWARE_TYPE		(-6)	// 未能支持的软件类型.
#define _SNM_TYPE_COMM_PROTOTOL_VER_NOTMATCH	(-5)	// 通讯协议版本不能匹配
#define _SNM_TYPE_REJECT_THE_ORDER_REQUEST		(-4)	// 订单被拒绝.
#define _SNM_TYPE_CHANGE_PASSWORD_FAIL			(-3)	// 修改密码失败.
#define _SNM_TYPE_INITIALIZATION_FAILURE		(-1)	// 初始化错误.
#define _SNM_TYPE_KICK_OUT_THE_FIRST_LOGIN		(-2)	// 因为重复登录被踢出.
#define _SNM_TYPE_UNKNOWN						0		// 未知道的消息类型
#define _SNM_TYPE_CHANGE_PASSWORD_SUCCESS		1		// 修改密码成功.
#define _SNM_TYPE_SESSION_INVALID               (-42)   // 断线重连 session 失效
#define _SNM_TYPE_CRD_REQUEST_SUCCESS       12      //CRD存取款，购买力限额，实时报价成功
#define _SNM_TYPE_CHANGE_SECOND_PASSWORD_SUCCESS            5		// 实则二次登陆密码成功.
#define _SNM_TYPE_RESET_SECOND_LOGINPASSWORD_SUCCESS		7		// 修改密码成功.
#define _SYN_TYPE_LOGIN_2ND_MOREN_DEVICE          (-39)    // 设备超过绑定上线
#define _SYN_TYPE_LOGIN_2ND_MOREN_SMSCOUNT          (-43)  //IND 超发短信
#define _SYN_TYPE_SESSION_LOGIN_SUCCESS (-45) ///session重连成功
#define _SYN_TYPE_SESSION_LOGIN_TIMEOUT (-44) /// session已超时失效，需重新登入
#define _SYN_TYPE_SESSION_LOGIN_INVALID (-42) /// 错误的session，需重新登入
#define _SYN_TYPE_DIVIDEND_ADD_FAIL (-47)  ///以股派息列表
#define _SYN_TYPE_DIVIDEND_ADD_SUCCESS 15 ///以股派息列表
struct CMS_SERVER_NOTIFY_MESSAGE
{
	int	   PkgSize ;		// 包大小.
	short  Type ;			// 协议类型: type = _MDPType_CMS_ServerNotify_Message
	int	   MessageType ;	// 消息类型.
} ;

#define	_MDPType_CMS_ClearStockTable			31004		//	server端 通知client 清掉股票列表.
// MDPHead + AccountID( string: size(short)+char[] )

#define	_MDPType_CMS_StockRecords				31005		//	server端 发送某账户的 持仓列表.
// MDPHead + AccountID( string: size(short)+char[] ) + Table(_DOMAIN_CMS_STOCK_RECORD)流化.

#define _MDPType_CMS_ServerResponse_ExchRateStart 32040
#define _MDPType_CMS_ServerResponse_ExchRateEnd 32042

#define	_MDPType_CMS_TodayOrders				31006		//	server端 发送某账户的 今日 order列表
// MDPHead + LoginID( string: size(short)+char[] ) + Table(_DOMAIN_CMS_TODAY_ORDER)流化.
#define _MDPType_CMS_GeryMarketTodayOrderNotify   31109    //委托推送，暗盘

#define _MDPType_CMS_GeryMarketTodayTradeNotify   31110     //成交推送，暗盘

#define _MDPType_CMS_GeryMarketCash                31105 //资金，暗盘

#define _MDPType_CMS_GeryMarketHoldStock           31106//持仓，暗盘

#define _MDPType_CMS_GeryMarketTodayOrder   31107    //委托，暗盘

#define _MDPType_CMS_GeryMarketTodayTrade   31108     //成交，暗盘

#define	_MDPType_CMS_ClientRequest_ItemInfo		31007		//	client端 请求某证券的信息( 应答是 _MDPType_Domain_Transfer(_DOMAIN_CMS_ITEM_INFO) )
// MDPHead + ItemCode( string: size(short)+char[] ) 

#define	_MDPType_CMS_ClientRequest_OrderRequest	31008		//	client端 下单
// MDPHead + Domain流化( _DOMAIN_CMS_ORDER_REQUEST )

#define	_MDPType_CMS_ClientRequest_ChangePassword 31009		//	client端 请求修改密码
// MDPHead + Domain流化( _DOMAIN_CMS_ORDER_REQUEST )

#define _MDPType_CMS_ClientRequest_LogOn_2nd    31076     //	client端 请求二次登录

#define _MDPType_CMS_2ND_ClientLogonResponse     31077       //Server端 应答修改二次登录密码 返回
#define _MTPType_CMS_AFE_ClientRequest_FortiManagement                    31853

#define _MTPType_CMS_AFE_ClientRequest_FortiManagement_OK    31854//重发验证码，更新双重认证和校验验证码 成功
#define _MTPType_CMS_AFE_ClientRequest_FortiManagement_Fail    31855//重发验证码，更新双重认证和校验验证码 失败

#define _MTPType_CMS_AFE_ClientReLoginRequest 32001
#define _MTPType_CMS_AFE_ClientReLoginRequest_OK 32002
#define _MTPType_CMS_AFE_ClientReLoginRequest_Failed 32003

#define	_MDPType_CMS_ClientRequest_2nd_ChangePassword 31078		//	client端 请求修改二次登录密码
// MDPHead + Domain流化( _DOMAIN_CMS_ORDER_REQUEST )

#define	_MDPType_CMS_ServerNotify_InitFinished	  31010		//	server端通知 初始化完成.
// MDPHead 
#define _MDPType_CMS_ServerResponse_LoginNotice   31050     //  server端通知

#define	_MDPType_CMS_TradeHistorys				  31011		//	server端 发送某账户的 交易明细记录.
// MDPHead + LoginID( string: size(short)+char[] ) + Table(_DOMAIN_CMS_TRADE_HISTORY)流化.

#define	_MDPType_CMS_ClientRequest_GetTradeHistory	31012		//	client端 请求 历史交易(累计).
// MDPHead + AccountID( string: size(short)+char[] )
#define _MDPType_CMS_TradeAccountList               31068

#define	_MDPType_CMS_ClientRequest_ItemBaseInfo		31013		//	client端 请求 个股的基本信息( 目前发往 RDS )
// CMS_CLIENT_REQUEST_ITEM_BASEINFO

#define _MDPType_CMS_ClientRequest_CCYRate	31014 /// client端 请求汇率（tanson 2012/01/18)

#define _MDPType_CMS_ClientRequest_LogOn_2nd_ReOTP    31093 // 请求 重发验证码ayers二重登录

#define _MDPType_CMS_ClientReponse_LogOn_2nd_ReOTP    31094    // 应答 重发验证码

#define _MDPType_CMS_ClientRequest_LogOn_2nd_Cancel   31095    // 请求 取消该设备绑定

#define _MDPType_CMS_ClientResponse_LogOn_2nd_Cancel  31096    // 应答 取消该设备绑定

#define _MDPType_CMS_ServerResponse_Client_2nd_Logon_Pass 31077    // 需要二次登录应答信息

#define _MDPType_CMS_ClientQuit                            31035  /// 方正客户端主动退出交易

#define _MDPType_CMS_ClientRequest_ReSetControl    32035   // 检查是否需要验证IDCODE BWG

struct CMS_CLIENT_REQUEST_ITEM_BASEINFO
{
	int	   PkgSize ;					// 包大小.
	short  Type ;						// 协议类型: type = _MDPType_CMS_ClientRequest_ItemBaseInfo
	char   ItemCode[SIZE_ITEMCODE] ;	// itemcode.
	short  Lang ;						// 语言类型.
	
} ;

#define	_MDPType_CMS_ServerResponse_ItemBaseInfo	31014		//	Server端 应答个股的基本信息. ( RDS应答 )
// CMS_SERVER_RESPONSE_ITEM_BASEINFO +  [ ( OK的情况下 ) Domain流化( _DOMAIN_CMS_ITEM_BASEINFO ) ]

struct CMS_SERVER_RESPONSE_ITEM_BASEINFO
{
	int	   PkgSize ;					// 包大小.
	short  Type ;						// 协议类型: type = _MDPType_CMS_ServerResponse_ItemBaseInfo
	char   ItemCode[SIZE_ITEMCODE] ;	// itemcode.
	short  Lang ;						// 语言类型.
	int    Status ;						// 回答状态:
	// -1, 无此证券代码.
	// 0,  OK.	
} ;

#define	_MDPType_CMS_ServerResponse_ItemSmartPeport	31015		//	Server端 应答个股的简洁报价信息.
// MDPHead + Domain流化( _DOMAIN_CMS_ITEM_SMARTREPORT ) ]

#define	_MDPType_CMS_NewTradeHistory				31016		//	server端 发送某账户的 新加的交易明细记录.
// MDPHead + LoginID( string: size(short)+char[] ) + Domain(_DOMAIN_CMS_TRADE_HISTORY).

#define	_MDPType_CMS_ClearCashMovement				31017		//	server端 通知client 清掉 资金变动表(Cash Movement )
// MDPHead + AccountID( string: size(short)+char[] )

#define	_MDPType_CMS_ReloadCashMovement				31018		//	server端 发送某账户的 资金变动表(Cash Movement )
// MDPHead + AccountID( string: size(short)+char[] ) + Table(_DOMAIN_CMS_CASH_MOVEMENT)流化.

#define	_MDPType_CMS_RealtimeCashMovement			31019		//	server端 增加的  资金变动记录(Cash Movement )
// MDPHead + AccountID( string: size(short)+char[] ) + Table(_DOMAIN_CMS_CASH_MOVEMENT)流化.

#define	_MDPType_CMS_ClearSecurityMovement			31020		//	server端 通知client 清掉 证券变动表(Security Movement )
// MDPHead + AccountID( string: size(short)+char[] )

#define	_MDPType_CMS_ReloadSecurityMovement			31021		//	server端 发送某账户的 证券变动表(Security Movement )
// MDPHead + AccountID( string: size(short)+char[] ) + Table(_DOMAIN_CMS_SECURITY_MOVEMENT)流化.

#define	_MDPType_CMS_RealtimeSecurityMovement		31022		//	server端 增加的  证券变动记录(Security Movement )
// MDPHead + AccountID( string: size(short)+char[] ) + Table(_DOMAIN_CMS_SECURITY_MOVEMENT)流化.

#define	_MDPType_CMS_ServerResponse_GetTradeHistory	31013		//	server端 应答 client端 请求历史交易(累计).
// MDPHead + AccountID( string: size(short)+char[] ) + Table(_DOMAIN_CMS_TRADE_HISTORY_EXT)流化.

#define	_MDPType_CMS_ServerResponse_ClientLastLogOn	31024		//	server端 发送的 客户最后登录信息( paul, 2009-5-26, add )
// CMS_SERVER_RESPONSE_CLIENT_LAST_LOGON

#define	_MDPType_CMS_ClientRequest_PreCheck			31025		//	client 发送的订单检查请求( Add by joe, 2010/9/14 )
#define	_MDPType_CMS_ServerResponse_PreCheck		31026		//	client 发送的订单检查请求( Add by joe, 2010/9/14 )

#define _MDPType_CMS_Gethttp_Codename		    31724  //figer FMN 获取外股信息
#define _MDPType_CMS_Gethttp_Codename_Response            31725//东信获取外股数据

#define _MDPType_CMS_GeryMarketUserInfo                        31108//判断是否在暗盘时段

#define	_MDPType_CMS_ClientRequest_ItemInfo_Domain		31080 //BCI  获取外股信息

#define	_MDPType_CMS_MultiCurrency_Update			31027		
//	发送货币table，避免发多条记录，最后发一个消息导致旧版本不能识别而出现空白提示( Add by joe, 2011/5/16 )

#define _MDPType_CMS_CCYRate_Update					31028		// server 端 应答汇率返回（tanson 2012/01/18)
#define _MDPType_CMS_ClientRequest_ResetPassword    31029       // client 请求重置密码

#define _MDPType_CMS_ClientRequest_Commition        31075

#define _MDPType_CMS_GETDEVICELIST             31111     //获取设备列表

struct CMS_SERVER_RESPONSE_CLIENT_LAST_LOGON
{
	int	   PkgSize ;				// 包大小.
	short  Type ;					// 协议类型: type = _MDPType_CMS_ClientLogonResponse
	char   LastLogonTime[30] ;		// 最后登录日期&时间.
	char   LastLogonResult[30] ;	// 最后登录状态.
	
} ;

struct CMS_SERVER_RESPONSE_CLIENT_LOGON_OK_ClientBank
{
    // 正确登录后提款户口信息:
    short  Type ;    
    char   Ccy_Type[20] ; // 币种
    char   Bank_Name[20] ; // 银行名称
    char   Bank_Account[20] ; // 银行户口
    char   Bank_Code[20];       // 银行代码
} ;

struct CMS_SERVER_RESPONSE_CLIENT_2ND_LOGON_OK_DATA
{
    // 正确登录后信息:
    
    int    MDF_Type ; // mdf类型
    
    
    char   MDF_UserName[20] ; // mdf系统的 用户名.
    char   MDF_UserPassword[20] ; // mdf系统的 用户密码.
    
    int    LastLogonDate ;//最后登录日期: YYMMDD
    int    LastLogonTime ; // 最后登录时间: hhmmss
    
    char   AccountID[20] ; //  帐户ID.
    
    int    ITS_Date ;//  iTrading server 当前日期， YYMMDD
    
    char   second_pwd_hints[20]; // 增加二次登录返回的提示编码
    char   RandomData[20];       // 初次登录应答返回的随机数字
} ;

struct CMS_SERVER_RESPONSE_CLIENT_2ND_LOGON_OK_DATA_IAISA
{
    // 正确登录后信息:
    
    int    MDF_Type ;                      // mdf类型
    
    char   MDF_UserName[20] ;              // mdf系统的 用户名.
    char   MDF_UserPassword[20] ;          // mdf系统的 用户密码.
    
    int          LastLogonDate ;              //       最后登录日期: YYMMDD
    int          LastLogonTime ;              //       最后登录时间: hhmmss
    
    char   AccountID[20] ;                  //  帐户ID.
    
    int          ITS_Date ;                //  iTrading server 当前日期， YYMMDD
    
    
    char   second_pwd_hints[20];          // 增加二次登录返回的提示编码
    char   RandomData[20];       // 初次登录应答返回的随机数字
    
    char   LastChangePSWDate[20]; // 上次修改密码的时间
    char   RemainingDate[20];     // 密码有效期剩余时间
    char   AlertChangePassWord[20]; // 是否需密码有效日的提醒，是否需强制修改密码
} ;

struct CMS_SERVER_RESPONSE_CLIENT_2ND_LOGON_OK_DATA_AYERS
{
    // 正确登录后信息:
    
    int    MDF_Type ; // mdf类型
   
    
    char   MDF_UserName[20] ; // mdf系统的 用户名.
    char   MDF_UserPassword[20] ; // mdf系统的 用户密码.
    
    int    LastLogonDate ;//最后登录日期: YYMMDD
    int    LastLogonTime ; // 最后登录时间: hhmmss
    
    char   AccountID[20] ; //  帐户ID.
    
    int    ITS_Date ;//  iTrading server 当前日期， YYMMDD
    
    char   second_pwd_hints[20]; // 增加二次登录返回的提示编码
    char   RandomData[20];       // 初次登录应答返回的随机数字
    
    int       nT_StartTime;         /// soft token的启动时间
    int       nT_EndTime;             /// soft token的启动时间
    int       nT_MidTimeNumber;     /// T-mid 还剩下的soft token天数
} ;

//FFG使用
struct CMS_SERVER_RESPONSE_CLIENT_LOGON_OK_DATA_EXT_FFG
{
    // 正确登录后信息:
    
    int    MDF_Type ;   // mdf类型
    
    char  MDF_UserName[20] ;  // mdf系统的 用户名.
    char  MDF_UserPassword[20] ; // mdf系统的 用户密码.
    
    int    LastLogonDate ;  // 最后登录日期: YYMMDD
    int    LastLogonTime ;  // 最后登录时间: hhmmss
    
    char  AccountID[20] ;  //  帐户ID.
    
    bool  m_alert_change_pwd;    // 提醒修改密码
    //  bool  m_force_change_pwd;    // 强制修改密码
    char  m_pwd_expiry_date[10];  // 密码过期日期
} ;

struct CMS_SERVER_RESPONSE_CLIENT_2ND_LOGON_OK_DATAEXT
{
    // 正确登录后信息:
    int    MDF_Type ;            // mdf类型
    char   MDF_UserName[20] ;        // mdf系统的 用户名.
    char   MDF_UserPassword[20] ;    // mdf系统的 用户密码.
    int       LastLogonDate ;        //    最后登录日期: YYMMDD
    int       LastLogonTime ;        //    最后登录时间: hhmmss
    char   AccountID[20] ;        //  帐户ID.
    int       ITS_Date ;            //  iTrading server 当前日期， YYMMDD
    char   address[50];            //  地址
    int    nInterval;            //  间隔时间
    char   terminal[50];        //  终端信息
    char   clientip[20];        // 客户端IP
    char   lastLogintime[20];    //  最后验证时间
    char   lastloginstatus[10];     //  上次登陆状态
    int    nDeveiceStatus;        //  是否是绑定用户   若 1 : 已经绑定  ； 若0 未绑定
} ;

//BCI  2FA  登陆协议修改 和 OTP验证 协议
struct CMS_SERVER_RESPONSE_CLIENT_2ND_LOGON_OK_DATAEXT_NEW
{
    // 正确登录后信息:
    
    int        MDF_Type ;            // mdf类型
    
    char    MDF_UserName[20] ;        // mdf系统的 用户名.
    char    MDF_UserPassword[20] ;    // mdf系统的 用户密码.
    
    int        LastLogonDate ;        //    最后登录日期: YYMMDD
    int        LastLogonTime ;        //    最后登录时间: hhmmss
    
    char    AccountID[20] ;        //  帐户ID.
    
    int        ITS_Date ;            //  iTrading server 当前日期， YYMMDD
    
    char    address[50];            //  地址
    int        nInterval;            //  间隔时间
    char    terminal[50];        //  终端信息
    char    clientip[20];        // 客户端IP
    char    lastLogintime[20];    //  最后验证时间
    char    lastloginstatus[10];     //  上次登陆状态
    int        nDeveiceStatus;        //  是否是绑定用户   若 1 : 已经绑定  ； 若0 未绑定
    
    char    LastChangePSWDate[20]; // 上次修改密码的时间
    char    RemainingDate[20];     // 密码有效期剩余时间
    char    AlertChangePassWord[20]; // 是否需密码有效日的提醒，是否需强制修改密码
} ;

struct CMS_SERVER_RESPONSE_CLIENT_2ND_LOGON_OK_DATAEXT_TAH
{
    // 正确登录后信息:
    int    MDF_Type ;            // mdf类型
    char   MDF_UserName[20] ;        // mdf系统的 用户名.
    char   MDF_UserPassword[20] ;    // mdf系统的 用户密码.
    int       LastLogonDate ;        //    最后登录日期: YYMMDD
    int       LastLogonTime ;        //    最后登录时间: hhmmss
    char   AccountID[20] ;        //  帐户ID.
    int       ITS_Date ;            //  iTrading server 当前日期， YYMMDD
    char   address[50];            //  地址
    int    nInterval;            //  间隔时间
    char   terminal[50];        //  终端信息
    char   clientip[20];        // 客户端IP
    char   lastLogintime[20];    //  最后验证时间
    char   lastloginstatus[10];     //  上次登陆状态
    int    nDeveiceStatus;        //  是否是绑定用户   若 1 : 已经绑定  ； 若0 未绑定
    
    char   LastChangePSWDate[20]; // 上次修改密码的时间
    char   RemainingDate[20];     // 密码有效期剩余时间
    char   AlertChangePassWord[20]; // 是否需密码有效日的提醒，是否需强制修改密码
} ;

struct CMS_SERVER_RESPONSE_CLIENT_NOTICE
{
    int PkgSize;
    short Type;
    char szStratDate[12];    //通知开始日期   格式：20171121
    char szEndDate[12];      //通知结束日期
    char szNotice[4096];     //通知内容
    BOOL bEnableTrade;       //是否可以进入交易    1可以  0不可以
};


struct CMS_SERVER_RESPONSE_IDLE_TIME
{
    int     PkgSize;
    short   Type;
    int     m_nMaxIdleTime;
    int     m_nDefaultIdleTime;
};

#define _MDPType_CMS_ServerResponse_IdleTime 31054 // 闲置时间


//////////////////////////////////////////////////////////////////////////////////////////////////
//  灵活的统一的 字段请求协议.

#define	_MDPType_CMS_Query_FieldValue				31100		//	某方查询字段值
// MDPHead + FieldName( string( size(short)+char[] ) 

#define	_MDPType_CMS_Answer_FieldValue_Faile		31101		//	返回查询字段值(失败)
// MDPHead + FieldName( string( size(short)+char[] ) + ErrorCode( int )

#define	_MDPType_CMS_Answer_FieldValue_OK			31102		//	返回查询字段值(成功)
// MDPHead + FieldName( string( size(short)+char[] ) ) + FieldVal( string( size(short)+char[] ) )

#define	_MDPType_CMS_Request_ModifyFieldValue		31103		//	请求 设置字段内容. 
// MDPHead + TransID(int) + FieldName( string( size(short)+char[] ) ) + FieldVal( string( size(short)+char[] ) )

#define	_MDPType_CMS_Response_ModifyField_State		31104		//	应答 请求设置字段内容的 结果.
// MDPHead + TransID(int) + statu(int)

//////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////
//  灵活的 domain, table传送协议

#define	_MDPType_Domain_Transfer					31200		//	Domain传送协议.
// MDPHead + Domain流化( 参见 domain.h中 STCDomain )

//#define	_MDPType_Table_Transfer						31201		//	Table传送协议.
//		// MDPHead + Table流化( 参见 domain.h中 STCTable )

//////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////
//  PKI方面协议.

#define	_MDPType_CMS_Client_Challenge_Server		31300		//	客户端挑战 server
// CMS_CLIENT_CHALLENGE_SERVER

struct CHALLENGE_INFO
{
	BYTE	HeadMark[4] ;			// 头标记.
	DWORD	Date ;					// 日期.
	BYTE	ChallengeInfo[24] ;		// 挑战信息.
	BYTE	Key[24] ;				// 加密的key.
	BYTE	EndMark[4] ;			// 尾部标记
	
};

struct CMS_CLIENT_CHALLENGE_SERVER
{
	int	   PkgSize ;			// 包大小.
	short  Type ;				// 协议类型: type = _MDPType_CMS_Client_Challenge_Server
	
	BYTE   EncryptInfo[128] ;	// 经过RSA public key加密的 ( 挑战信息 + key ).
	
} ;


#define	_MDPType_CMS_Server_Challenge_Client		31301		//	server应答挑战, 并且挑战client
// CMS_CLIENT_CHALLENGE_SERVER(_MDPType_CMS_Server_Challenge_Client)

#define	_MDPType_CMS_ChallengePass					31302		//	client检查server应答, 并且回应挑战. 
// CMS_CLIENT_CHALLENGE_SERVER(_MDPType_CMS_ChallengePass)

#define	_MDPType_CMS_EncryptPkg						31303		//	加密包.
// 协议:MDPHead  + EncryptData.

// AES256加解密
#define _MDPType_CMS_EncryptPkg_AES256 31307

#define    _MDPType_PingRequest               10012        // ping协议
#define    _MDPType_PingAnswer                10013        // ping应答协议

//////////////////////////////////////////扩展的CMS_CLIENT_CHALLENGE_SERVER结构用于新的加密方式
/*
 * RSA加密强度采用最新的2048
 * AES加密模式: 256_cbc
 * 向量iv: for(i = 0; i < 16; ++i) m_Iv[i] = i;
 * 密钥: CHALLENGE_INFO_AES中的key
 * 挑战阶段31305: 用31304的key解密EncryptInfo中的内容(CHALLENGE_INFO_AES)
 * 挑战完成，发送数据包使用31305中的key，协议类型为31037 */
struct CHALLENGE_INFO_AES
{
    BYTE    HeadMark[4] ;
    DWORD   Date ;
    BYTE    ChallengeInfo[32] ;
    BYTE    Key[32] ;
    BYTE    EndMark[4] ;
    // 头标记.
    // 日期.
    // 挑战信息.
    // 加密的key.
    // 尾部标记
};


// 加密强度提升至2048 
struct CMS_CLIENT_CHALLENGE_SERVER_NEW //tiger 2017
{
    int	   PkgSize ;			// 包大小.
    short  Type ;				// 协议类型: type = _MDPType_CMS_Client_Challenge_Server
    
    BYTE   EncryptInfo[256] ;	// 经过RSA public key加密的 ( 挑战信息 + key ). 从128 扩至256
    
} ;

#define	_MDPType_CMS_Client_Challenge_Server_NEW		31304		//	客户端挑战 server,加密强度提升至2048
#define	_MDPType_CMS_Server_Challenge_Client_NEW		31305		//	server应答挑战, 并且挑战client，加密强度提升至2048
#define	_MDPType_CMS_ChallengePass_NEW				    31306		//	client检查server应答, 并且回应挑战，加密强度提升至2048




//////////////////////////////////////////////////////////////////////////////////////////////////

//willy 2009-07-11

#define	_MDPType_CMS_Request_StockRecord_Start	   31401	// 通知客户端开始接收Stock Records
// MDPHead + AccountID( string: size(short)+char[] )

#define	_MDPType_CMS_Request_StockRecord_End	   31402	// 通知客户端结束接收Stock Records
// MDPHead + AccountID( string: size(short)+char[] )



#define	_MDPType_CMS_Request_LoadOrder_Start	   31403	// 通知客户端开始接收Stock Records
// MDPHead + AccountID( string: size(short)+char[] )

#define	_MDPType_CMS_Request_LoadOrder_End	        31404		// 通知客户端结束接收Stock Records
// MDPHead + AccountID( string: size(short)+char[] )


#define	_MDPType_CMS_Trade_History_Start	   31405	    // 通知客户端开始接收Stock Trade history
// MDPHead + AccountID( string: size(short)+char[] )

#define	_MDPType_CMS_Trade_History_End	        31406		// 通知客户端结束接收Stock Trade history
// MDPHead + AccountID( string: size(short)+char[] )



#define	_MDPType_CMS_Load_Details_Start			 31407	    // 
// MDPHead + AccountID( string: size(short)+char[] )

#define	_MDPType_CMS_Load_Details_End	        31408		// 
// MDPHead + AccountID( string: size(short)+char[] )

#define    _MDPType_CMS_GetCCYRate_Start       31426        // 通知客户端开始接收ccyrate

#define    _MDPType_CMS_GetCCYRate_End            31427        // 通知客户端结束接收ccyrate

//willy 2009-07-16

#define _MDPType_CMS_Cash_Balance_Request		    31409  //	请求获取用户资金信息
#define _MDPType_CMS_Multi_Currency_Balance_Request 31410  //   请求获取多种资金组合
#define _MDPType_CMS_Stock_Holding_Request          31411  //	请求持有股票信息
#define _MDPType_CMS_OneStock_Holding_Request       31412  //   查询是否有一支股票
#define _MDPType_CMS_Cash_Movement_Request          31413  //   现金交易信息
#define _MDPType_CMS_Stock_Movement_Request         31414  //   股票交易信息
#define _MDPType_CMS_Today_Order_Request            31415  //   今日股票交易信息 
#define _MDPType_CMS_Load_Order_Details_Request     31416  //   所以股票交易明细
#define _MDPType_CMS_Load_Trade_History_Request     31417  //   历史股票信息
#define _MDPType_CMS_Connect_Start_Request		    31418  //	请求连接开始
#define _MDPType_CMS_Client_Data_Request		    31419  //	请求连接开始
#define _MDPType_CMS_Client_MultiCurr_Request		31420  //	多币种请求
#define _MDPType_CMS_Currency_Update_End			31421  //   币种更新结束
#define _MDPType_CMS_Client_BankBrokerHistory_Request 31422  //查询存款记录  tiger - 2015 02 24
#define _MDPType_CMS_ClientRequest_GetBankBrokerList     31620 //查询银行代理  weber 2015 02 26
#define _MDPType_CMS_Add_New_Bank_Broker                 31618 //提交转账 weber 2015 02 27
#define _MDPType_CMS_CashInfoRecords                     31076 //  figer 16.11.25
// add by ben 2014-01-20
#define _MDPType_CMS_ReqTradeDate                   31423  //   隔夜单请求 for CIS

#define _MDPType_CMS_Client_CCYRate_Request        31425  //    多币种汇率请求  GSL

//Willy Add IPO 协议.


#define _MDPType_CMS_IPO_AddNewIPORequest		    31501  //	请求新增IPO
#define _MDPType_CMS_IPO_UpdateIPORequest		    31502  //	请求更新IPO

#define _MDPType_CMS_IPO_GetIPOList	                31503  //	请求获取IPO列表
#define _MDPType_CMS_IPO_GetIPOListStart            31504  //发送给客户端开始记录
#define _MDPType_CMS_IPO_GetIPOListEnd	            31505  //发送给客户端结束记录


#define _MDPType_CMS_IPO_GetIPODetail	            31506  //	请求获取IPO股票代码明细
#define _MDPType_CMS_IPO_GetIPOApplyDetail	        31507  //	请求获取正在使用IPO明细

#define _MDPType_CMS_IPO_GetIPOApplication          31508  //	请求获取已经申请的IPO明细
#define _MDPType_CMS_IPO_GetIPOApplicationStart     31509  //	发送给客户端获取开始记录
#define _MDPType_CMS_IPO_GetIPOApplicationEnd       31510  //	发送给客户端获取结束记录

#define _MDPType_CMS_IPO_GetIPOUpdateDetail         31511  //	请求获取IPO更新明细
#define _MDPType_CMS_IPO_GetIPOFinancingDetail      31512  //	请求获取IPO融资明细



//Willy Add 银证转帐协议.

#define _MDPType_CMS_SK_Add_Notice_Order_Request	31601  //	请求新增Notice Order 记录
#define _MDPType_CMS_SK_GetNotice_Order             31602  //	请求获取银证转帐的用户信息列表
#define _MDPType_CMS_SK_GetNotice_Order_Start       31603  //	请求获取银证转帐的用户信息列表
#define _MDPType_CMS_SK_GetNotice_Order_End         31604  //	请求获取银证转帐的用户信息列表




#define _MDPType_CMS_SK_GetSecuritiesAccount        31608  //	请求获取银证转帐的银行列表
#define _MDPType_CMS_SK_GetSecuritiesAccountStart   31609  //	发送给客户端获取开始记录
#define _MDPType_CMS_SK_GetSecuritiesAccountEnd     31610  //	发送给客户端获取结束记录


#define _MDPType_CMS_SK_GetPayForCustomers_Request  31611  //	请求获取用户支付信息
#define _MDPType_CMS_SK_GetPayForCustomers_Info     31612  //	请求获取银证转帐的用户信息列表
#define _MDPType_CMS_SK_GetPayForCustomers_Start    31613  //	请求获取银证转帐的用户信息列表
#define _MDPType_CMS_SK_GetPayForCustomers_End      31614  //	请求获取银证转帐的用户信息列表

#define _MDPType_CMS_ClientRequest_OrderEnq		    31071  //   请求委托明细
#define _MDPType_CMS_ClientRequest_CashMovement     31073  //   请求资金流水for-CIC
#define _MDPType_CMS_ClientRequest_StockMovement    31074  //   请求股票流水for-CIC
#define _MDPType_CMS_CAS_Currency                   31832  //   请求入金账户for-CIC
#define _MDPType_CMS_CAS_Currency_Response          31833  //   请求入金账户for-CIC 响应
#define _MDPType_CMS_CAS_Account                    31830  //   CAS Account请求协议：for-CIC
#define _MDPType_CMS_CAS_Account_Response           31831 //   CAS Account请求协议：for-CIC 响应

#define _MDPType_CMS_ClientRequest_MaxBuyQty        31072  //   请求当前股票最大可买数
#define _MDPType_CMS_ClientRequest_OrderCharge      31069  //   请求下单时改单的佣金税费
#define _MDPType_CMS_ReloadCashMovement				31018 
#define _MDPType_CMS_ClientRequest_Portfolio        21000  //   请求资金汇总
#define _MDPType_CMS_ClientRequest_LogOn_2nd_new    32036  //   Token校验
#define _MDPType_CMS_ClientRequest_CaccCredit       22000  //   请求追按金日數
//end Willy 银证转帐协议

#define _MDPType_CMS_ClientRequest_OrderEnq    31071    //查询多个交易对手 FOR-CRD
#define _MDPType_CMS_ClientRequest_Apply_purchase_limits    31079 //请求购买力申请 FOR-CRD
#define _MDPType_CMS_ServerResponse_Client_Bank_accs   31049  //提款户口获取 FOR-CRD
#define _MDPType_CMS_ClientResponse_PayeeBankInfo   31098     //取款户口获取 FOR-ISR
#define _MDPType_CMS_SK_CASH_Withdrawal_Request     31605    //提款指示 FOR CRD
#define _MDPType_CMS_SK_Add_Notice_Order_Request    31601     //存款指示 for CRD
#define _MDPType_CMS_ClientRequest_OrderCancelRTQ   31091     //for crd 实时报价申请
#define _MDPType_CMS_Bank_Broker_History_Start	31616       // 发送给客户端获取开始记录(查询存款记录)
#define _MDPType_CMS_Bank_Broker_History_End 	31617       // 发送给客户端获取结束记录
#define _MDPType_CMS_ServerResponse_GetBankBrokerHistory 31621//(查询存款记录)
#define _MDPType_CMS_SystemSetting                31815    //  获取可用的存取款方式 请求

//收到请求  weber 2015 02 26
#define _MDPType_CMS_Bank_Broker_List_Start				 31623
#define _MDPType_CMS_Bank_Broker_List_End		         31624
//  client端请求存取款的银行信息
#define _MDPType_CMS_ClientRequest_BankInfo              31080
//client端 存款银行户口 应答
#define _MDPType_CMS_ClientResponse_BankInfo             31097
// 取款请求:
#define _MDPType_CMS_ClientRequest_PayeeBankInfo         31092
// client端 取款银行户口 应答
#define _MDPType_CMS_ClientResponse_PayeeBankInfo        31098
//最高可提取金额:
//请求:
#define _MDPType_CMS_ClientBalance_Enquiry               31045

//CTS可取现金余额应答：
#define _MDPType_CMS_GETClientBlance                     31112

// client端 最高可提取金额 应答
#define _MDPType_CMS_ClientResponse_Enquiry              31082

//end Willy 银证转帐协议

//wede EIPO(AYERS柜台)协议
//IPO
#define _MDPType_CMS_ClientRequest_IPO_Master       32004   //请求查询IPO列表的请求
#define _MDPType_CMS_ServerResponse_IPO_Master       32009  //获取IPO列表
#define _MDPType_CMS_ServerResponse_IPO_Master_Qty   32010  //获取多个IPO的数量和申请资金
#define _MDPType_CMS_ServerResponse_IPO_Master_Tier  32031  //获取IPO的资金和汇率
#define _MDPType_CMS_ServerResponse_IPO_Master_Nationality  32032  //获取 多国家  add by weber


#define _MDPType_CMS_ClientRequest_IPO_Submit       32003   //提交申请（第1次）
#define _MDPType_CMS_ServerResponse_IPO_Submit       32008  //获取返回推送的信息

#define _MDPType_CMS_ClientRequest_IPO_Submit_Confim  32002  //提交申请，该次的参数来源于第一次提交返回的数据（第2次）
#define _MDPType_CMS_ServerResponse_IPO_Submit_Confim  32007 //

#define _MDPType_CMS_ClientRequest_IPO_ENQ          32000 //查询持有的IPO（我的IPO）
#define _MDPType_CMS_ServerResponse_IPO_ENQ          32005

//IPO

//2Go
#define _MDPType_CMS_2GO_Stock_Holding_Request          31045  //	请求持有股票信息

#define _MDPType_CMS_ClientResponse_Enquiry   31082


#pragma pack(8)

#define _MDPType_CMS_FDTAILOGIN 31813 //BCI的FDTAI请求
#define  _MDPType_CMS_FDTAILOGOUT  31814

#define _MTPType_CMS_AFE_ClientRequest_Logout 31900
#define _MTPType_CMS_AFE_ClientRequest_Logout_OK 31901
#define _MTPType_CMS_AFE_ClientRequest_Logout_Failed 31902


#define _MTPType_CMS_AFE_ClientRequest_2nd_Cancel 32011
#define _MTPType_CMS_AFE_ClientRequest_2nd_Cancel_Failed 32012

#define _MTPType_CMS_AFE_ClientRequest_2nd_login_Failed 32006


//获取 银行转账历史记录
#define _MDPType_CMS_GetBankHistory 31812

#define _DOMAIN_CMS_REQUEST_BANK_HISTORY "RHS"
#define _BANKHISTORY_REQUEST_ACCOUNTID "AC" //账户
#define _DOMAIN_CMS_CAS_CURRENCY_REQUEST  "CCQ"//入金
#define _DOMAIN_CMS_CAS_ACCOUNT_REQUEST                "CAQ"


#define _MDPType_Domain_Transfer 31200

#define _DOMAIN_CMS_RESPONSE_BANK_HISTORY "BHS"
#define _GETBANK_RESPONSE_INFOCOUNT "IC" //总数

#define _DOMAIN_CMS_RESPONSE_BANK_HISTORY_INFO "BHIF"
#define _BANKHISTORY_INFO_SEQ "SQ"
#define _BANKHISTORY_INFO_INSID "INID"
#define _BANKHISTORY_INFO_BANKACC "ACC"//银行账户
#define _BANKHISTORY_INFO_BANKNAME "NA"//银行名称
#define _BANKHISTORY_INFO_DATETIME "DT"//日期
#define _BANKHISTORY_INFO_BANKTYPE "TY"//存款(传递D)/取款(传递W)
#define _BANKHISTORY_INFO_BANKCCY "CY"//货币
#define _BANKHISTORY_INFO_AMOUNT "AT"//金额
#define _BANKHISTORY_INFO_STATUS "ST"//状态(P = Pending A = Accept R = Reject)
#define _BANKHISTORY_INFO_REMARK "RM"//备注
#define _BANKHISTORY_INFO_METHOD "MT"//存取款方式
/*存款方式
2 银行转账
3 支票
4 现金
5 内部转账
6 转账自期权账户
7 转账自期货账户
8 基金转移
取款方式
0 银行转账
1 支票
3 汇款
4 本地银行跨行转账
5 内部转账
6 转账至期权账户
7 转账至期货账户*/
#define _BANKHISTORY_INFO_CHANNEL "CL"//输入通道
#define _BANKHISTORY_INFO_TDATE "TAD"//存款交割日期
#define _BANKHISTORY_INFO_TTIME "TM"//存款交割时间
#define _BANKHISTORY_INFO_FCCY "FCY"//


#define _DOMAIN_CMS_RESPONSE_BANK_HISTORY_END "HED"

//获取取款银行列表
#define _MDPType_CMS_GetBankList 31811

#define _DOMAIN_CMS_REQUEST_BANK_LIST "RBL"
#define _ADDBANK_REQUEST_BANK_ACCOUNTID "AID"//登陆ID


//返回
#define _MDPType_Domain_Transfer 31200

#define _DOMAIN_CMS_RESPONSE_BANK_LIST "RPBL"
#define _GETBANK_RESPONSE_BANKCOUNT "BC"


#define _DOMAIN_CMS_RESPONSE_BANK_LIST_INFO "BIF"
#define _BANKLIST_INFO_BANKSEQ "SEQ"
#define _BANKLIST_INFO_BANKACC "ACC"//银行账户
#define _BANKLIST_INFO_BANKNAME "NA"//银行名称
#define _BANKLIST_INFO_BANKTYPE "TY"//存/取款
#define _BANKLIST_INFO_BANKCURR "CR"//货币
#define _BANKLIST_INFO_BANKMETHOD "MH"//存取款类型


#define _DOMAIN_CMS_RESPONSE_BANK_LIST_END "BED"

//GYS 集成出入金H5的接口
#define _MDPType_CMS_ClientRequest_H5                    32043

#define _DOMAIN_CMS_REQUEST_H5                           "H5"
#define  _H5_REQUEST_CLIENT_ID                          "id"       // 请求流水 单号或当前时间戳
#define  _H5_REQUEST_CLIENT_tradeAccount                "ACC"      // 交易账户
#define  _H5_REQUEST_CLIENT_accountType                 "AccType"  // 账号类型
#define  _H5_REQUEST_CLIENT_module                      "Mod"      // 请求模块(默认跳转到资金首页)
#define  _H5_REQUEST_CLIENT_deviceCode                  "Dev"      // 设备唯一标识
#define  _H5_REQUEST_CLIENT_osType                      "OS"       // 操作系统类型(0安卓，1苹果，2 WP)
#define  _H5_REQUEST_CLIENT_deviceType                  "DevType"  // 设备类型(0 PC; 1 手机; 2 平板)
#define  _H5_REQUEST_CLIENT_appVersion                  "AppV"     // 产品版本
#define  _H5_REQUEST_CLIENT_lang                        "lang"     // 语言环境 zh_HK-繁体 zh_CN-简体中文
#define  _H5_REQUEST_CLIENT_time                        "time"     // 当前时间戳, 单位为秒
#define  _H5_REQUEST_CLIENT_rand                        "rand"     // 随机串，无符号10进制整数，用户需自行生成，最长 10 位
// 回复终端接口
#define  _MDPType_Domain_Transfer              31200               //  Domain传送协议.

#define _HT_RESPONSE_URL                                 "URL"     // url

//存取款指令
#define  _MDPType_CMS_AddBankIns  31810

#define  _DOMAIN_CMS_REQUEST_ADDBANKINS  "ABI"
#define  _ADDBANK_REQUEST_BANK_ACCOUNTID  "AID" // 账户
#define  _ADDBANK_REQUEST_BANK_ACC  "BAC"  //银行账户
#define  _ADDBANK_REQUEST_BANK_TYPE  "BTY" // 存取款(存款D  取款W)
#define  _ADDBANK_REQUEST_BANK_CCY  "CCY"  //货币类型(#define _DOMAIN_CMS_RESPONSE_BANK_LIST_INFO "BIF"的#define _BANKLIST_INFO_BANKCURR "CR"//货币)
#define _ADDBANK_REQUEST_BANK_AMOUNT "AO" // 金额
#define _ADDBANK_REQUEST_BANK_REMARK "RM" // 备注
#define _ADDBANK_REQUEST_BANK_METHOD "MT" // 存取款方式
#define _ADDBANK_REQUEST_BANK_VERTYPE    "VT"  //标记新旧版本，0：旧，1：新；

/*存款方式
2 银行转账
3 支票
4 现金
5 内部转账
6 转账自期权账户
7 转账自期货账户
8 基金转移
取款方式
0 银行转账
1 支票
3 汇款
4 本地银行跨行转账
5 内部转账
6 转账至期权账户
7 转账至期货账户*/
#define _ADDBANK_REQUEST_BANK_DATE "DT" //日期
#define _ADDBANK_REQUEST_BANK_TIME "TM" //时间
#define _ADDBANK_REQUEST_BANK_PW "PW" //交易密码
#define _ADDBANK_REQUEST_BANK_FCCY "FCCY" //目前传空
#define _ADDBANK_REQUEST_BANK_IMGTY "IMGTY" //上传文件的文件扩展名
#define _ADDBANK_REQUEST_BANK_IMG "IMG"// base64编码后的图片数据
#define _ADDBANK_REQUEST_BANK_REMARK_UTF    "RMU"
#define _ADDBANK_REQUEST_BANK_REMARK_LANGUAGE    "RML"
//_ADDBANK_REQUEST_BANK_IMG 和 _ADDBANK_REQUEST_BANK_IMGTY字段
/*存款的2 银行转账/3 支票/4 现金 需要传递
其他情况传递空
*/





//返回
#define _MDPType_Domain_Transfer 31200

#define _DOMAIN_CMS_ADD_BANK_INS_RESPONSE "ABIN"
#define _ADDBANK_INS_RESPONSE_ACCID "AID" // 账户
#define _ADDBANK_INS_RESPONSE_RESULT "RR" // Y成功 N失败
#define _ADDBANK_INS_RESPONSE_ERR_EN "EN" // 错误提示
#define _ADDBANK_INS_RESPONSE_ERR_TW "TW"
#define _ADDBANK_INS_RESPONSE_ERR_CN "CN"
#define _ADDBANK_INS_RESPONSE_INSID "ISID"



//撤销操作
#define _MDPType_CMS_CancelBankIns 31815

#define _DOMAIN_CMS_REQUEST_BANK_CANCEL "CAN"
#define _CANCELBANK_REQUEST_INSID "INID" //序号 (#define _DOMAIN_CMS_RESPONSE_BANK_HISTORY_INFO "BHIF" 的 #define _BANKHISTORY_INFO_INSID "INID" //序号 撤销指令传递这个字段)


//返回
#define _MDPType_Domain_Transfer 31200

#define _MDPType_Domain_portfolio 31034

#define _DOMAIN_CMS_RESPONSE_BANK_CANCEL "RCAN"
#define _CANCELBANK_RESPONSE_MSG "MSGR" //Success/Payment Instruction not found/Only pending instruction can be cancelled/You don't have permission to cancel instruction for this client

//返回撤销操作的操作结果 Success 成功 其他的是 失败的错误提示
//撤销操作 只能操作
#define _DOMAIN_CMS_RESPONSE_BANK_HISTORY_INFO "BHIF"// #define _BANKHISTORY_INFO_STATUS "ST"
//这个字段为 Pen 的记录
//Accept/Reject的记录不能撤销

//获取列表  BCI企业行动
#define _MDPType_CMS_GetCAList 31816
#define _DOMAIN_CMS_REQUEST_CA_LIST    "CAL"
#define _BCICA_REQUEST_LIST_AID        "AID"    //用户登陆ID



//开始返回
#define _DOMAIN_CMS_RESPONSE_CAL_START "CLS"
#define _BCICA_RESPONSE_CAL_COUNT "CLC"       //    列表总数
//列表项
#define _DOMAIN_CMS_RESPONSE_CAL "CLL"
#define _BCICA_RESPONSE_CAL_SEQ "SEQ"       //    序号
#define _BCICA_RESPONSE_CAL_CAFER "CAF"
#define _BCICA_RESPONSE_CAL_CATYPE "CAT"
#define _BCICA_RESPONSE_CAL_EXC "EXC"       //    Exchange Code
#define _BCICA_RESPONSE_CAL_PRC "PRC"        //   Product Code
#define _BCICA_RESPONSE_CAL_PRS "PRS"        //   Product Short Name
#define _BCICA_RESPONSE_CAL_EPC    "EPC"       //    Entitled Product Code
#define _BCICA_RESPONSE_CAL_EPS    "EPS"      //     Entitled Product Short Name
#define _BCICA_RESPONSE_CAL_DL    "DL"        //   Deadline
#define _BCICA_RESPONSE_CAL_DEP    "DEP"      //     Description
#define _BCICA_RESPONSE_CAL_CCY    "CCY"      //     货币
#define _BCICA_RESPONSE_CAL_AM    "AM"        //   Dividend Amount
#define _BCICA_RESPONSE_CAL_PRI    "PRI"        //   Reinvestment Price
#define _BCICA_RESPONSE_CAL_BCQ    "BCQ"        //   Book Close Qty
#define _BCICA_RESPONSE_CAL_RPQ    "RPQ"        //   Reply_Qty
#define _BCICA_RESPONSE_CAL_DATE "DT"        // 服务器当前日期 用于过期检测

//返回列表结束
#define _DOMAIN_CMS_RESPONSE_CAL_END "CLE"


//申请企业行动
#define _MDPType_CMS_AddCAIns 31817
#define _DOMAIN_CMS_REQUEST_ADDCAINS "ACI"
#define _BCICA_REQUEST_INS_AID "AID"    //用户登陆ID
#define _BCICA_REQUEST_INS_CAR "CAR"    //获取列表的返回中的#define _DOMAIN_CMS_RESPONSE_CAL "CLL" 中的 #define _BCICA_RESPONSE_CAL_CAFER "CAF"
#define _BCICA_REQUEST_INS_REQ "REQ"    //用户输入的 以股代息的股数

#define _MDPType_Domain_Transfer 31200
#define _DOMAIN_CMS_ADD_CA_INS_RESPONSE "ACIN"
#define _ADDCA_INS_RESPONSE_RESULT "RR"    // 返回结果 Y成功 N失败
#define _ADDCA_INS_RESPONSE_ERR "ERR"        // 错误信息


//获取可申购IPO信息请求和应答字段信息
#define _MDPType_CMS_IPO_GetIPOList               31503

//获取单个IPO信息请求和应答字段信息
#define _MDPType_CMS_IPO_GetIPOApplyDetail         31507

//收费信息请求/应答字段信息
#define _MDPType_CMS_IPO_GetIPODetail             31506

//融资利率信息请求/应答字段信息
#define _MDPType_CMS_IPO_GetIPOFinancingDetail     31512

//Qty和Cost信息请求/应答字段信息
#define _MDPType_CMS_IPO_GetIPOAppShares         31514

//已申购IPO信息请求/应答字段信息
#define _MDPType_CMS_IPO_GetIPOApplication        31508

//已申购IPO的历史记录请求/应答
#define _MDPType_CMS_IPO_GetIPOApplicationHistory   31513

//下单、改撤单请求和应答字段信息
#define _MDPType_CMS_IPO_AddNewIPORequest          31501
#define _MDPType_CMS_IPO_UpdateIPORequest          31502

//检查是否需要验证IDCODE BWG 发送请求
#define _DOMAIN_CMS_RESET_CONTROL "RSC"
//回复
#define _MDPType_Domain_Transfer 31200
#define _DOMAIN_CMS_RESET_CONTROL "RSC"

#define _RESET_PASSWORD_RADOME_INPUTFLAG "INF"
///True 表示 需要进行IDCODE验证 False 表示不需要进行IDCODE验证


#define _RESET_PASSWORD_RADOME_INPUTPATTERN "INP"
///验证模式
////F   模式     格式 Fn n为数字 表示 校验IDCODE前n个字符
////L   模式     格式 Ln n为数字 表示 校验IDCODE后n个字符 (不包括括号中的数字 如果有括号)
////ALL 模式     格式 ALL 表示 校验IDCODE全部数字(不包括括号中的数字 如果有括号)
////ALL*模式     格式 ALL*表示 校验IDCODE全部数字(包括括号中的数字 如果有括号)
//重置密码
//发送请求
//#define _MDPType_CMS_ClientRequest_ResetPassword 31029
#define _DOMAIN_CMS_RESET_PASSWORD "RP"

#define _RESET_PASSWORD_PROP_LOGINID "LID"
///登陆ID
#define _RESET_PASSWORD_PROP_EMAIL "EM"
///账户绑定邮箱
#define _RESET_PASSWORD_PROP_VALIDATE "VD"
///接口返回True 这里就使用True
///接口返回False这里就使用False
#define _RESET_PASSWORD_PROP_IDCODE "IC"
///用户输入的IDCODE
//回复
//成功没回复
//失败返回通过
//#define _MDPType_CMS_ServerNotify_Message 31003
//消息类型 -10

//1. 请求以股派息列表协议：
#define _MDPType_CMS_DividendList                                  31819
#define _DOMAIN_CMS_DIVIDEND_REQUEST  "DVR"
#define _DIVIDEND_REQUEST_ACCOUNT           "DRA" ///账号

//   列表数据返回
#define _MDPType_CMS_DividendListResponse                   31820
#define _DOMAIN_CMS_DIVIDEND                   "DVD"
#define _DIVIDEND_ACCOUNT                            "DAT" ///账号
#define _DIVIDEND_CLIENTNAME                      "DCA" ///客户英文名称
#define _DIVIDEND_STOCKCODE                       "DSC" ///股票代码
#define _DIVIDEND_QTY                                     "DDQ" ///可以以股派息的股数
#define _DIVIDEND_STOCKNAME                      "DSN" ///股票英文名称
#define _DIVIDEND_STOPTIME                          "DST" ///截止时间，格式YYYY-MM-DD
#define _DIVIDEND_DIVIDEND                          "DIV" ///每股股息，最多会有7位小数
#define _DIVIDEND_PRICE                                 "DDP" ///招股价
#define _DIVIDEND_ANNOUNCEMENTNO       "DAN" ///参考ID
#define _DIVIDEND_AENO                                 "DAE" ///参考经纪号


//2. 以股派息申请
#define _MDPType_CMS_DividendAdd                                   31821
#define _DOMAIN_CMS_DIVIDEND_ADD         "DDA"
#define _DIVIDEND_ADD_ACCOUNT                  "DAA" ///客户账号
#define _DIVIDEND_ADD_CLIENTNAME             "DAC" ///客户英文名称
#define _DIVIDEND_ADD_AE                               "DAE" ///客户经纪号
#define _DIVIDEND_ADD_CASHQTY                   "DCQ" ///现金股数
#define _DIVIDEND_ADD_SHAREQTY                 "DSQ" ///股票股数
#define _DIVIDEND_ADD_STOCKCODE              "DSC" ///股票代码，5位
#define _DIVIDEND_ADD_ANNOUNNO              "DAN" ///参考ID
#define _DIVIDEND_ADD_INPUTTIME                 "DAI" ///客户端输入的日期时间 YYYY-MM-DD HH:MM:SS


//1. 以股派息申請記錄查詢接口
#define   _MDPTYPE_CMS_DIVIDENDRECORD                        31822
#define _DOMAIN_CMS_DIVIDENDRECORD        "DDA"
#define _DIVIDENDRECORD_ACCOUNT          "DRA" ///账号

#define   _MDPTYPE_CMS_DIVIDENDRECORDRESPONSE                 31823

#define  _DIVIDENDRECORD_DAA  "DAA" // 客户账号
#define  _DIVIDENDRECORD_DAC  "DAC" // 客户英文名称
#define  _DIVIDENDRECORD_DAE  "DAE" // 客户经纪号
#define  _DIVIDENDRECORD_DCQ  "DCQ" // 现金股数
#define  _DIVIDENDRECORD_DSQ  "DSQ" // 股票股数
#define  _DIVIDENDRECORD_DSC  "DSC" // 股票代码，5位
#define  _DIVIDENDRECORD_DAN  "DAN" // 参考ID
#define  _DIVIDENDRECORD_DAI  "DAI" // 客户端输入的日期时间 YYYY-MM-DD HH:MM:SS

//交银绑卡授权EDDA请求
#define _MDPType_CMS_ClientRequest_BCI_SDDA_SETUP     32144

#define _DOMAIN_CMS_REQUEST_BCI_SDDA_SETUP  "RBES"    ///请求
#define _DOMAIN_REQ_BES_D_ACCOUNT  "AT"              ///用户的帐号登陆接口获取
#define _DOMAIN_REQ_BES_D_DEBTORNAME "DE"           ///用户的帐号登陆接口获取，BIG5编码
#define _DOMAIN_REQ_BES_D_DEBTORACCBANKCODE "DBC"               ///_MDPType_CMS_GetBankList 返回的数据
#define _DOMAIN_REQ_BES_D_DEBTORACCNUMBER "DAN"                  ///
#define _DOMAIN_REQ_BES_D_DEBTORACCTCURRENCY "DAC"                  ///
#define _DOMAIN_REQ_BES_D_DEBTORIDTYPE "DT"          ///BR-商业登记证，CI–中国居民身份证，ID–香港居民身份证，PP–护照
#define _DOMAIN_REQ_BES_D_DEBTORID "DI"             ///帐号信息
#define _DOMAIN_REQ_BES_D_DEPOSITAMTLIMIT "DAL"      ///最大限额
#define _DOMAIN_REQ_BES_D_REMARK "RE"                ///备注信息
#define _DOMAIN_REQ_BES_D_DEBTORNAME_GB    "DEG"

#define _DOMAIN_CMS_RESPONSE_BCI_SDDA_SETUP "PBES"   ///返回
#define _DOMAIN_RSP_BES_D_REJECT_STATUS "ST"             ///拒绝状态
#define _DOMAIN_RSP_BES_D_REJECT_REASON "RR"             ///拒绝原因
#define _DOMAIN_RSP_BES_D_TRANSACTION_DATE_TIME "TDT"         ///
#define _DOMAIN_RSP_BES_D_DDA_REFERENCE "DR"              ///EDDA编号，其它命令需要使用
#define _DOMAIN_RSP_BES_D_REMARK "RE"                 ///备注
#define _DOMAIN_RSP_BEE_D_ERROR_CODE "EC"                 ///
#define _DOMAIN_RSP_BEE_D_ERROR_DESCRIPTION "ES" ///

//交银EDDA绑定列表查询
#define _MDPType_CMS_ClientRequest_BCI_SDDA_ENQUIRY                     32145
#define _DOMAIN_CMS_REQUEST_BCI_SDDA_ENQUIRY        "RBEE"     ///请求
#define _DOMAIN_REQ_BEE_D_ACCOUNTID    "ID"                  ///用户的帐号登陆接口获取

#define _DOMAIN_CMS_RESPONSE_BCI_SDDA_ENQUIRY_START        "PBEES"
#define _DOMAIN_RSP_BEES_D_NO_OF_RECORDS    "ID"            ///数量
#define _DOMAIN_RSP_BEES_D_ERROR_CODE    "EC"
#define _DOMAIN_RSP_BEES_D_ERROR_DESCRIPTION    "ES"

#define _DOMAIN_CMS_RESPONSE_BCI_SDDA_ENQUIRY        "PBEE"   ///返回
#define _DOMAIN_RSP_BEE_D_RESPONSE_SEQ    "RS"
#define _DOMAIN_RSP_BEE_D_ACCOUNT_ID    "AI"                  ///帐号
#define _DOMAIN_RSP_BEE_D_DDA_REFERENCE    "DR"               ///EDDA编号，其它命令需要使用
#define _DOMAIN_RSP_BEE_D_STATUS    "ST"                      ///状态
#define _DOMAIN_RSP_BEE_D_REJECT_REASON    "RR"
#define _DOMAIN_RSP_BEE_D_TRANSACTION_DATE_TIME    "TDT"
#define _DOMAIN_RSP_BEE_D_CREDIT_ACC_NUMBER    "CAN"          ///用户的帐号
#define _DOMAIN_RSP_BEE_D_CREDIT_ACC_TYPE    "CAT"            ////
#define _DOMAIN_RSP_BEE_D_DEBTOR_NAME    "DN"                 ///用户姓名
#define _DOMAIN_RSP_BEE_D_DEBTOR_ACC_BANKCODE    "DAB"        ///银行编号
#define _DOMAIN_RSP_BEE_D_DEBTOR_ACC_NUMBER    "DAN"          ///银行帐号
#define _DOMAIN_RSP_BEE_D_DEBTOR_ACC_CURRENCY    "DAC"        ///货币
#define _DOMAIN_RSP_BEE_D_DEPOSIT_AMT_LIMIT    "DAL"          ///限额
#define _DOMAIN_RSP_BEE_D_EXPIRY_DATE    "ED"                 ///过期时间
#define _DOMAIN_RSP_BEE_D_PAYMENT_PERIOD    "PP"
#define _DOMAIN_RSP_BEE_D_REMARK    "RE"                      ///备注
#define _DOMAIN_RSP_BEE_D_DEBTOR_ACCOUNTID_TYPE    "DAT"
#define _DOMAIN_RSP_BEE_D_DEBTOR_ID_NUMBER    "DIN"
#define _DOMAIN_CMS_RESPONSE_BCI_SDDA_ENQUIRY_END        "PBEEE"


//交银edda入金请求
#define _MDPType_CMS_ClientRequest_BCI_DDI_REQUEST             32146

#define _DOMAIN_CMS_REQUEST_BCI_DDI_REQUEST  "RBDR"    ///请求
#define _DOMAIN_REQ_BDR_D_ACCOUNTID  "ID"              ///用户的帐号登陆接口获取
#define _DOMAIN_REQ_BDR_D_DDAAREFERENCE "DR"           ///命令SDDA_ENQUIRY获取
#define _DOMAIN_REQ_BDR_D_CURRENCY "CUR"               ///货币单位
#define _DOMAIN_REQ_BDR_D_AMOUNT "AM"                  ///数量
#define _DOMAIN_REQ_BDR_D_REMARK "RM"                  ///备注信息

#define _DOMAIN_CMS_RESPONSE_BCI_DDI_REQUEST "PBDR"   ///返回
#define _DOMAIN_RSP_BDR_D_ACCOUNT_ID "AI"             ///用户的帐号
#define _DOMAIN_RSP_BDR_D_REFERENCE "REF"             ///DDI 的编号
#define _DOMAIN_RSP_BDR_D_DDA_REFERENCE "DRE"         ///DDA 的编号
#define _DOMAIN_RSP_BDR_D_CURRENCY "CUR"              ///货币
#define _DOMAIN_RSP_BDR_D_AMOUNT "AM"                 ///数量
#define _DOMAIN_RSP_BDR_D_STATUS "ST"                 ///状态
#define _DOMAIN_RSP_BDR_D_INSTRUCTION_DATE_TIME "IDT" ///Instruction datetime (YYYYMMDDHHMMSS)
#define _DOMAIN_RSP_BDR_D_ERROR_CODE "EC"
#define _DOMAIN_RSP_BDR_D_ERROR_DESCRIPTION "ED"
#define _DOMAIN_RSP_BDR_D_REJECT_REASON "RR"
#define _DOMAIN_RSP_BDR_D_REMARK "RE"

//交银edda入金记录查询
#define _MDPType_CMS_ClientRequest_BCI_DDI_ENQUIRY                      32147
#define _DOMAIN_CMS_REQUEST_BCI_DDI_ENQUIRY        "RBDE" ///请求
#define _DOMAIN_REQ_BDE_D_ACCOUNTID    "AI"               ///用户的帐号登陆接口获取
#define _DOMAIN_REQ_BDE_D_DDIREFERENCE    "DR"            ///
#define _DOMAIN_REQ_BDE_D_FROMDATE    "FD"
#define _DOMAIN_REQ_BDE_D_TODATE    "TD"

#define _DOMAIN_CMS_RESPONSE_BCI_DDI_ENQUIRY_START        "PBDES" ///返回
#define _DOMAIN_RSP_BDE_D_NOOFRECORDS    "NOR"                    ///记录数量
#define _DOMAIN_RSP_BDE_D_ERROR_CODE    "EC"                      ///错误编码
#define _DOMAIN_RSP_BDE_D_ERROR_DESCRIPTION    "ED"               ///错误描述信息
#define _DOMAIN_CMS_RESPONSE_BCI_DDI_ENQUIRY        "PBDE"
#define _DOMAIN_RSP_BDE_D_RESPONSE_SEQ    "RS"
#define _DOMAIN_RSP_BDE_D_ACCOUNT_ID    "AI"
#define _DOMAIN_RSP_BDE_D_REFERENCE    "REF"
#define _DOMAIN_RSP_BDE_D_DDA_REFERENCE    "DR"
#define _DOMAIN_RSP_BDE_D_CURRENCY    "CUR"
#define _DOMAIN_RSP_BDE_D_AMOUNT    "AM"
#define _DOMAIN_RSP_BDE_D_STATUS    "ST"
#define _DOMAIN_RSP_BDE_D_REJECT_REASON    "RR"
#define _DOMAIN_RSP_BDE_D_INSTRUCTION_DATE_TIME    "IDT"
#define _DOMAIN_RSP_BDE_D_PROCESSED_DATE_TIME    "PDT"
#define _DOMAIN_RSP_BDE_D_REMARK    "RMK"
#define _DOMAIN_CMS_RESPONSE_BCI_DDI_ENQUIRY_END        "PBDEE"


//交银供股接口
//Retrieve Rights List
//请求协议类型：
#define _MDPType_CMS_ClientRequest_BCI_RIGHTSLIST_REQUEST              32401
//请求：
#define _DOMAIN_CMS_GETRIGHTSLIST_REQUEST "GRL"
#define _GETRIGHTSLIST_PROP_ACCOUNTID "AID"
#define _GETRIGHTSLIST_PROP_REFID "RI"
#define _GETRIGHTSLIST_PROP_HEADERONLY "HO"
//应答协议类型：
#define _MDPType_Domain_Transfer 31200//Domain传送协议.
//应答：
#define _DOMAIN_CMS_RESPONSE_BCI_RIGHTSLIST_START "RBRS"
#define _DOMAIN_RSP_BRS_D_RESPONSE_ERRORCODE "EC"
#define _DOMAIN_RSP_BRS_D_RESPONSE_ERRORDESCRIPTION "ED"
#define _DOMAIN_CMS_RESPONSE_BCI_RIGHTSLIST_END "RBRE"
//应答：
#define _DOMAIN_CMS_RESPONSE_BCI_MASTERLIST_START "RBMS"
#define _DOMAIN_RSP_BMS_D_RESPONSE_NO_OFRCODE "NOR"


#define _DOMAIN_CMS_RESPONSE_BCI_MASTERLIST  "RBML"
#define _DOMAIN_RSP_BML_D_RESPONSE_SEQ "RS"
#define _DOMAIN_RSP_BML_D_RESPONSE_REF_NO "RN"
#define _DOMAIN_RSP_BML_D_RESPONSE_ACTION_TYPE "AT"
#define _DOMAIN_RSP_BML_D_RESPONSE_STATUS "RT"
#define _DOMAIN_RSP_BML_D_RESPONSE_COMPANY_CODE "RCC"//公司代码
#define _DOMAIN_RSP_BML_D_RESPONSE_EXCHANGE_CODE "REC"
#define _DOMAIN_RSP_BML_D_RESPONSE_RIGHT_CODE "RRC"
#define _DOMAIN_RSP_BML_D_RESPONSE_RIGHT_NAME "RRN"
#define _DOMAIN_RSP_BML_D_RESPONSE_RIGHT_NAME2 "RRN2"
#define _DOMAIN_RSP_BML_D_RESPONSE_RIGHT_SHORT_NAME "RRSN"
#define _DOMAIN_RSP_BML_D_RESPONSE_RIGHT_LOT_SIZE "RRLS"
#define _DOMAIN_RSP_BML_D_RESPONSE_PRODUCT_CODE "RPC"
#define _DOMAIN_RSP_BML_D_RESPONSE_PRODUCT_NAME "RPN"
#define _DOMAIN_RSP_BML_D_RESPONSE_PRODUCT_NAME2 "RPN2"
#define _DOMAIN_RSP_BML_D_RESPONSE_PRODUCT_SHORT_NAME "RPSN"
#define _DOMAIN_RSP_BML_D_RESPONSE_PRODUCT_LOT_SIZE "RPLS"
#define _DOMAIN_RSP_BML_D_RESPONSE_SUBSCRIPTION_DATE "RSD"
#define _DOMAIN_RSP_BML_D_RESPONSE_ALLOTMENT_DATE "RAD"
#define _DOMAIN_RSP_BML_D_RESPONSE_REFUND_DATE "RRD"
#define _DOMAIN_RSP_BML_D_RESPONSE_SUBSCRIPTION_CCY "RSC"
#define _DOMAIN_RSP_BML_D_RESPONSE_SUBSCRIPTION_PRICE "RSP"

#define _DOMAIN_CMS_RESPONSE_BCI_MASTERLIST_END "RBME"

//应答：
#define _DOMAIN_CMS_RESPONSE_BCI_ENTITLEMENTLIST_START "RBES"
#define _DOMAIN_RSP_BES_D_RESPONSE_NO_OFRCODE "NOR"

#define _DOMAIN_CMS_RESPONSE_BCI_ENTITLEMENTLIST "RBEL"
#define _DOMAIN_RSP_BEL_D_RESPONSE_SEQ "RS"
#define _DOMAIN_RSP_BEL_D_RESPONSE_REF_NO "RN"
#define _DOMAIN_RSP_BEL_D_RESPONSE_RIGHT_CODE "RRC"
#define _DOMAIN_RSP_BEL_D_RESPONSE_ACCOUNT_NO "RAN"
#define _DOMAIN_RSP_BEL_D_RESPONSE_ACCOUNT_NAME "RAM"
#define _DOMAIN_RSP_BEL_D_RESPONSE_ACCOUNT_NAME2 "RAM2"
#define _DOMAIN_RSP_BEL_D_RESPONSE_AE_CODE "RAC"
#define _DOMAIN_RSP_BEL_D_RESPONSE_LEDGE_QTY "RLQ"
#define _DOMAIN_CMS_RESPONSE_BCI_ENTITLEMENTLIST_END "RBEE"

//应答：

#define _DOMAIN_CMS_RESPONSE_BCI_SUBSCRIPTION_START "RBSS"
#define _DOMAIN_RSP_BSS_D_RESPONSE_NO_OFRCODE "NOR"
#define _DOMAIN_CMS_RESPONSE_BCI_SUBSCRIPTION "RBSP"
#define _DOMAIN_RSP_BSP_D_RESPONSE_SEQ "RS"
#define _DOMAIN_RSP_BSP_D_RESPONSE_REF_NO "RN"
#define _DOMAIN_RSP_BSP_D_RESPONSE_STATUS "RT"
#define _DOMAIN_RSP_BSP_D_RESPONSE_ACCOUNT_NO "RAN"
#define _DOMAIN_RSP_BSP_D_RESPONSE_AE_CODE "RAC"
#define _DOMAIN_RSP_BSP_D_RESPONSE_SUBSCRIPTION_QTY "RSQ"
#define _DOMAIN_RSP_BSP_D_RESPONSE_EXCESS_SUBSCRIPTION_QTY "RESQ"
#define _DOMAIN_RSP_BSP_D_RESPONSE_SUBSCRIPTION_ATM "RSA"
#define _DOMAIN_CMS_RESPONSE_BCI_SUBSCRIPTION_END "RBSE"
#define _DOMAIN_RSP_BSP_D_RESPONSE_ALLOTMENT_QTY                "RAQ"
#define _DOMAIN_RSP_BSP_D_RESPONSE_EXCESS_ALLOTMENT_QTY         "REAQ"
#define _DOMAIN_RSP_BSP_D_RESPONSE_REPLY_TIMESTAMP              "RRT"

//Submit Rights Subscription申请认购供股
//请求协议类型：
#define _MDPType_CMS_ClientRequest_BCI_RIGHTS_SUBSCRIPTION_REQUEST     32402
//请求：
#define _DOMAIN_CMS_SUBMITRIGHTSSUBSRCIPTION_REQUEST  "SRP"
#define _SUBMITRIGHTSSUBSRCIPTION_PROP_ACCOUNTID  "AID"
#define _SUBMITRIGHTSSUBSRCIPTION_PROP_REFNO  "RN"
#define _SUBMITRIGHTSSUBSRCIPTION_PROP_SUBSCRIPTIONQTY  "SQ"
//应答协议类型：
#define _MDPType_Domain_Transfer 31200//Domain传送协议.
//应答：
#define _DOMAIN_CMS_RESPONSE_BCI_SUBMITRIGHT "RBST"
#define _DOMAIN_RSP_BST_D_RESPONSE_ERRORCODE "EC"
#define _DOMAIN_RSP_BST_D_RESPONSE_ERRORDESCRIPTION  "ED"
#define _DOMAIN_RSP_BST_D_RESPONSE_ACCOUNT_NO "RAN"
#define _DOMAIN_RSP_BST_D_RESPONSE_REF_NO "RN"
#define _DOMAIN_RSP_BST_D_RESPONSE_AE_CODE "RAC"
#define _DOMAIN_RSP_BST_D_RESPONSE_SUBSCRIPTION_QTY "RSQ"
#define _DOMAIN_RSP_BST_D_RESPONSE_EXCESS_SUBSCRIPTION_QTY "RESQ"
#define _DOMAIN_RSP_BST_D_RESPONSE_SUBSCRIPTION_ATM "RSA"
//Calculate Rights Fee 供股费用
#define _MDPType_CMS_ClientRequest_BCI_CALCULATE_RIGHTS_FEE_REQUEST     32403
#define  _DOMAIN_CMS_CALCULATE_RIGHTS_FEE_REQUEST                       "CRF"
#define _CALCULATE_RIGHTS_FEE_PROP_ACCOUNTID                            "CRA"
#define _CALCULATE_RIGHTS_FEE_PROP_REFNO                                "CRR"
#define _CALCULATE_RIGHTS_FEE_PROP_SUBSCRIPTIONQTY                      "CRS"
#define _CALCULATE_RIGHTS_FEE_PROP_EXCESS_SUBSCRIPTIONQTY               "CRES"
//应答：
//#define _MDPType_Domain_Transfer                                        31200
#define _DOMAIN_CMS_RESPONSE_BCI_CALCULATE    "RBCT"
#define _DOMAIN_RSP_BCE_D_RESPONSE_ERRORCODE    "BEC"
#define _DOMAIN_RSP_BCE_D_RESPONSE_ERRORDESCRIPTION     "BED"
#define _DOMAIN_RSP_BCE_D_RESPONSE_ACCOUNT_NO        "BRAN"
#define _DOMAIN_RSP_BCE_D_RESPONSE_REF_NO        "BRN"
#define _DOMAIN_RSP_BCE_D_RESPONSE_AE_CODE        "BRAC"
#define _DOMAIN_RSP_BCE_D_RESPONSE_SUBSCRIPTION_QTY        "BRSQ"
#define _DOMAIN_RSP_BCE_D_RESPONSE_EXCESS_SUBSCRIPTION_QTY        "BRESQ"
#define _DOMAIN_RCE_BCE_D_RESPONSE_SUBSCRIPTION_ATM        "BRSA"
#define _DOMAIN_RCE_BCE_D_RESPONSE_DEPOSIT_FEE        "BRDF"
#define _DOMAIN_RCE_BCE_D_RESPONSE_HANDING_FEE        "BRHF"
#define _DOMAIN_RCE_BCE_D_RESPONSE_CLEARING_FEE        "BRCF"
#define _DOMAIN_RCE_BCE_D_RESPONSE_COMMISSION_FEE        "BRSF"
#define _DOMAIN_RCE_BCE_D_RESPONSE_LEVY_FEE        "BRLF"
#define _DOMAIN_RCE_BCE_D_RESPONSE_TRADING_FEE        "BRTF"
#define _DOMAIN_RCE_BCE_D_RESPONSE_FRC_FEE        "BRFF"
#define _DOMAIN_RCE_BCE_D_RESPONSE_OTHER_FEE        "BROF"



#define _MDPType_CMS_QUERY_CheckSignStatus    32310
#define _MDPType_CMS_MODIFY_SignUserProtocol   32312

#define _DOMAIN_CMS_REQUEST_ACC_QAD        "QAD"
#define _DOMAIN_CMS_RESPONSE_ACC_QADP      "QADP"

#define _DOMAIN_CMS_REQUEST_MODIFY_ACC_MAD        "MAD"
#define _DOMAIN_CMS_RESPONSE_MODIFY_ACC_MADP      "MADP"

#define _DOMAIN_ACC_DETAIL_CAC             "CAC"
#define _DOMAIN_ACC_DETAIL_PW              "PW"
#define _DOMAIN_ACC_DETAIL_SIG             "SIG"
#define _DOMAIN_ACC_DETAIL_CAN             "CAN"
#define _DOMAIN_ACC_DETAIL_SUC             "SUC"
//雷达,CTS签署投资者识别码返回的h5链接
#define _DOMAIN_ACC_DETAIL_URL             "URL"


//国都FPS出金 EDDA_FPS出金接口
//请求协议类型：
#define _MDPType_CMS_ClientRequest_BCI_FPS_REQUEST                      32148
    //请求：
    #define _DOMAIN_CMS_REQUEST_BCI_FPS_REQUEST            "RBFR"
    #define _DOMAIN_REQ_BFR_D_ACCOUNTID                "AI"
    #define _DOMAIN_REQ_BFR_D_BANKCODE                "BC"
    #define _DOMAIN_REQ_BFR_D_BANKACCOUNTNUMBER        "BNU"
    #define _DOMAIN_REQ_BFR_D_BANKACCOUNTNAME              "BNA"
    #define _DOMAIN_REQ_BFR_D_CURRENCY                 "CU"
    #define _DOMAIN_REQ_BFR_D_AMOUNT                 "AM"
    #define _DOMAIN_REQ_BFR_D_INSTRUCTIONTYPE               "IT"
    #define _DOMAIN_REQ_BFR_D_REMARK                       "RE"
//应答协议类型：
#define    _MDPType_Domain_Transfer            31200            //    Domain传送协议.请求：
    //应答：
    #define _DOMAIN_CMS_RESPONSE_BCI_FPS_RESPONSE        "PBFR"
    #define _DOMAIN_RSP_BFR_D_ACCOUNT_ID            "AI"
    #define _DOMAIN_RSP_BFR_D_REFERENCE_ID            "RI"
    #define _DOMAIN_RSP_BFR_D_BANK_CODE                "BC"
    #define _DOMAIN_RSP_BFR_D_BANK_ACCOUNT_NUMBER    "BA"
    #define _DOMAIN_RSP_BFR_D_BANK_ACCOUNT_NAME        "BAN"
    #define _DOMAIN_RSP_BFR_D_CURRENCY                "CUR"
    #define _DOMAIN_RSP_BFR_D_AMOUNT                "AM"
    #define _DOMAIN_RSP_BFR_D_INSTRUCTION_TYPE        "IT"
    #define _DOMAIN_RSP_BFR_D_STATUS                "ST"
    #define _DOMAIN_RSP_BFR_D_REJECT_REASON            "RR"
    #define _DOMAIN_RSP_BFR_D_INSTRUCTION_DATE_TIME    "IDT"
    #define _DOMAIN_RSP_BFR_D_REMARK                "RM"
    #define _DOMAIN_RSP_BFR_D_ERROR_CODE            "EC"
    #define _DOMAIN_RSP_BFR_D_ERROR_DESCRIPTION        "ED"

//EDDA_FPS 出金记录查询
//请求协议类型：
#define _MDPType_CMS_ClientRequest_BCI_FPS_ENQUIRY                      32149
    //请求：
    #define _DOMAIN_CMS_REQUEST_BCI_FPS_ENQUIRY            "RBFE"
    #define _DOMAIN_REQ_BFE_D_ACCOUNTID                "AI"
    #define _DOMAIN_REQ_BFE_D_REFERENCEID                "RI"
    #define _DOMAIN_REQ_BFE_D_FROMDATE                "FD"
    #define _DOMAIN_REQ_BFE_D_TODATE                    "TD"
//应答协议类型：
#define    _MDPType_Domain_Transfer            31200            //    Domain传送协议.请求：
    //应答：
    #define _DOMAIN_CMS_RESPONSE_BCI_FPS_ENQUIRY_START            "PBFES"
    #define _DOMAIN_CMS_RESPONSE_BCI_FPS_ENQUIRY                "PBFE"
    #define _DOMAIN_CMS_RESPONSE_BCI_FPS_ENQUIRY_END            "PBFEE"


    #define _DOMAIN_RSP_BFE_D_RESPONSE_SEQ            "RS"
    #define _DOMAIN_RSP_BFE_D_ACCOUNT_ID            "AI"
    #define _DOMAIN_RSP_BFE_D_REFERENCE_ID            "RI"
    #define _DOMAIN_RSP_BFE_D_BANK_CODE            "BC"
    #define _DOMAIN_RSP_BFE_D_BANK_ACCOUNT_NUMBER    "BA"
    #define _DOMAIN_RSP_BFE_D_BANK_ACCOUNT_NAME    "BAN"
    #define _DOMAIN_RSP_BFE_D_CURRENCY            "CUR"
    #define _DOMAIN_RSP_BFE_D_AMOUNT            "AM"
    #define _DOMAIN_RSP_BFE_D_INSTRUCTION_TYPE        "IT"
    #define _DOMAIN_RSP_BFE_D_STATUS                "ST"
    #define _DOMAIN_RSP_BFE_D_REJECT_REASON        "RR"
    #define _DOMAIN_RSP_BFE_D_INSTRUCTION_DATE_TIME    "IDT"
    #define _DOMAIN_RSP_BFE_D_REMARK                "RM"
//


// FSS EDDA
#define _MDPType_CMS_EDDA_APPLY               31840                         //直接收款授权请求
#define   _MDPType_Domain_Transfer            31200//直接收款授权或者直接入金应答：
#define _MDPType_CMS_EDDA_QUERY               31842                         //查询授权结果 request
#define _MDPType_CMS_EDDA_QUERY_RESPONSE      31843                         //查询授权结果应答
#define _MDPType_CMS_DDI_APPLY                31844                         //直接入金
#define _MDPType_CMS_DDI_QUERY                31846                         //查询入金结果 request
#define _MDPType_CMS_DDI_QUERY_RESPONSE       31847                         //查询入金结果 应答
#define _MDPType_CMS_BANK_INFO_QUERY          31848                         //查询银行信息
#define _MDPType_CMS_BANK_INFO_QUERY_RESPONSE 31849                         //查询银行信息 应答

#define _MDPType_CMS_EDDA_BANK_QUERY          31852//查询客户授权银行信息
#define _MDPType_CMS_EDDA_BANK_RESPONSE       31853//应答协议类型：
#define _MDPType_CMS_MODIFY_EDDA_LIMIT_QUERY  31854//修改单笔限额
#define _MDPType_CMS_EDDA_STATUS_QUERY        31850//查询客户授权状态
#define _MDPType_CMS_USER_INFO_QUERY           31856


#define _EDDA_APPLY_EAA                       "EAA"
#define _EDDA_REQUEST_QUERY_EAQ               "EAQ"
#define _EDDA_RESPONSE_QUERY_EAQP             "EAQP"
#define _DDI_APPLY_DIA                        "DIA"
#define _DDI_REQUEST_QUERY_DIQ                "DIQ"
#define _DDI_RESPONSE_QUERY_DIQP              "DIQP"
#define _BANK_INFO_QUERY_BKQ                  "BKQ"
#define _BANK_INFO_QUERY_BKQP                 "BKQP"
#define _EDDA_BANK_INFO_QUERY_EBQ             "EBQ"
#define _EDDA_BANK_INFO_QUERY_EBQP            "EBQP"
#define _EDDA_BANK_LIMIT_QUERY_MLQ            "MLQ"
#define _EDDA_BANK_LIMIT_QUERY_MLQP           "MLQP"
#define _EDDA_AUTHORIZATIONSTATUS_QUERY_ESQ   "ESQ"
#define _EDDA_AUTHORIZATIONSTATUS_QUERY_ESQP  "ESQP"
#define _EDDA_REQUEST_CLIENTINFO_QUERY_UIQ    "UIQ"
#define _EDDA_RESPONSE_CLIENTINFO_QUERY_UIQP  "UIQP"


#define _EDDA_APPLY_UserID                    "CAC"
#define _EDDA_APPLY_PW                        "PW"
#define _EDDA_APPLY_CreditorAcc               "CDA"

#define _EDDA_APPLY_UerID                     "CAC"   //交易账户
#define _EDDA_APPLY_PW                        "PW" //用户密码
#define _EDDA_APPLY_CreditorAcc               "CDA"         //收款账户银行号
#define _EDDA_APPLY_CreditorAccType           "CAT"            //收款账号资料类型：1 - Account Number 2 - Email Address 3 - Mobile Number 4 - FPS Identifiler
#define _EDDA_APPLY_SeqType                   "ST"     //指示类型
#define _EDDA_APPLY_DebtorName                "DN"        //扣款账户名称
#define _EDDA_APPLY_DebtorBankID              "DB"          //扣款账户银行编号
#define _EDDA_APPLY_DebtorBankName            "DBN"          //扣款账户银行名称
#define _EDDA_APPLY_DebtorAccType             "DAT"          //扣款账户资料类型: 1 - Recurrent  2 -One-off
#define _EDDA_APPLY_DebtorAcc                 "DA"       //扣款账户号码
#define _EDDA_APPLY_PayerName                 "PN"       //付款人姓名
#define _EDDA_APPLY_PayerType                 "PT"       //付款人类型: 1 - PERS-Personal   2 - CORP-Corporate
#define _EDDA_APPLY_CcyCode                   "CD"     //币种
#define _EDDA_APPLY_ExpireDate                "ED"        //到期日期: 格式yyyy/mm/dd，以市场时间为准
#define _EDDA_APPLY_PaymentPeriodicity        "PPT"               //付款周期: Y - Annual  M - Monthly  Q - Quarterly  H - Semi Annual  W - Weekly  D - Daily  P - Adhoc  F - Fortnightly
#define _EDDA_APPLY_PaymentMode               "PM"         //付款方式: 1 - Maximum Payment Mode    2 - Fix Payment Mode
#define _EDDA_APPLY_LimitAmount               "LA"         //付款限额
#define _EDDA_APPLY_MaxCount                  "MC"      //最高交易次数
#define _EDDA_APPLY_UITO                      "UITO"//证件类型1: 1 - HKID  2 - Passport Number 3 - Mobile Number 4 - Business Registration  5 - Certificate of Incorporation  6 - Others
#define _EDDA_APPLY_UIO                       "UIO"//证件号码1
#define _EDDA_APPLY_UITT                      "UITT"//证件类型2: 1 - HKID  2 - Passport Number 3 - Mobile Number 4 - Business Registration  5 - Certificate of Incorporation  6 - Others
#define _EDDA_APPLY_UIT                       "UIT"//证件号码2
#define _EDDA_APPLY_UITH                      "UITH"//证件类型3: 1 - HKID  2 - Passport Number 3 - Mobile Number 4 - Business Registration  5 - Certificate of Incorporation  6 - Others
#define _EDDA_APPLY_UIH                       "UIH"//证件号码3
#define _EDDA_APPLY_RMK                       "RMK"//备注

#define _DDI_APPLY_PC                         "PC"//交易目的码：1 - S-Success  2 - F-Fail  3 - P-Processing  4 - R-Transaction reject  5 - T - Timeout  6 - C-Confirm results via transaction activity enquiry function
#define _DDI_APPLY_AM                         "AM"//发生金额
#define _DDI_APPLY_CCY                        "CC"//币种
#define _DDI_Query_Status                     "STS"//状态
#define _DDI_Query_RJC                        "RJC"//拒绝代码
#define _DDI_Query_RJR                        "RJR"//拒绝理由
#define _DDI_Query_TradeDate                  "DT"//交易日期
#define _DDI_Query_TradeTime                  "TM"//交易时间
#define _DDI_Query_RFN                        "RFN"//交易备查号

#define _EDDA_PKI                             "PKI" //EDDA序号

#define _EDDA_Bank_User_ID                    "BUI"
#define _EDDA_Bank_ID                         "BI"
#define _EDDA_Bank_Name                       "BN"
#define _EDDA_Bank_Type                       "BT"
#define _EDDA_Trade_Type                      "TT"



#define _EDDA_Ccy_code                        "CCY"
#define _EDDA_Status                          "STS"
#define _EDDA_Single_limit                    "SL"


#define _EDDA_UPDATE_DebtorAcc                "DBA"






//========财通国际eDDA相关接口======
#define _MDPType_CMS_ClientRequest_CTS_EDDA_INFO_BANK     32201
#define _MDPType_CMS_ClientResponse_CTS_EDDA_INFO_BANK    32202
#define _MDPType_CMS_ClientRequest_CTS_EDDA_INFO_CLIENT   32203
#define _MDPType_CMS_ClientResponse_CTS_EDDA_INFO_CLIENT  32204
#define _MDPType_CMS_ClientRequest_CTS_EDDA_REQUEST       32205
#define _MDPType_CMS_ClientResponse_CTS_EDDA_REQUEST      32206
#define _MDPType_CMS_ClientRequest_CTS_EDDA_OTP_GENERATE  32207
#define _MDPType_CMS_ClientResponse_CTS_EDDA_OTP_GENERATE 32208
#define _MDPType_CMS_ClientRequest_CTS_EDDA_OTP_VERIFY    32209
#define _MDPType_CMS_ClientResponse_CTS_EDDA_OTP_VERIFY   32210


#define _MDPType_CMS_ClientRequest_CTS_EDDA_REGISTE_HISTORY 32213
#define _MDPType_CMS_ClientResponse_CTS_EDDA_REGISTE_HISTORY 32214
#define _MDPType_CMS_ClientResponse_CTS_EDDA_CASH_IN     32211

//财通EDDA及DDI相关接口
#define _DOMAIN_CMS_REQUEST_CTS_EDDA_BANK_INFO            "REBI"
  #define _DOMAIN_REQ_EBI_ACCOUNT                         "AT"
#define _DOMAIN_CMS_RESPONSE_CTS_EDDA_BANK_INFO           "PEBI"
  #define _DOMAIN_RSP_EBI_EDDA_PROVIDER_CODE              "EPC"
  #define _DOMAIN_RSP_EBI_BANK_CODE                       "BC"
  #define _DOMAIN_RSP_EBI_NAME                            "N"
  #define _DOMAIN_RSP_EBI_MAX_TRANSFER_LIMIT              "MTL"
  #define _DOMAIN_RSP_EBI_BIG5_NAME                       "BN"
  #define _DOMAIN_RSP_EBI_GB_NAME                         "GN"

#define _DOMAIN_CMS_REQUEST_CTS_EDDA_CLIENT_INFO          "RECI"
  #define _DOMAIN_REQ_ECI_CLIENT_ACC_CODE                 "CAC"
  #define _DOMAIN_REQ_ECI_INFO_TYPE                       "IT"
#define _DOMAIN_CMS_RESPONSE_CTS_EDDA_CLIENT_INFO         "PECI"
  #define _DOMAIN_REQ_ECI_USER_CODE                       "UC"
  #define _DOMAIN_RSP_ECI_EDDA_CLIENT_ACC_CODE            "EPC"
  #define _DOMAIN_RSP_ECI_NAME                            "BC"
  #define _DOMAIN_RSP_ECI_ENG_NAME                        "N"
  #define _DOMAIN_RSP_ECI_BIG5_NAME                       "MTL"
  #define _DOMAIN_RSP_ECI_GB_NAME                         "BN"
  #define _DOMAIN_RSP_ECI_MOBILE                          "M"
  #define _DOMAIN_RSP_ECI_ID_TYPE                         "IT"
  #define _DOMAIN_RSP_ECI_ID_CODE                         "IC"

#define _DOMAIN_CMS_REQUEST_CTS_EDDA_REQUEST              "RER"
  #define _DOMAIN_REQ_CER_CLIENT_ACC_CODE                 "CAC"
  #define _DOMAIN_REQ_CER_EDDA_PROVIDER_CODE              "EPC"
  #define _DOMAIN_REQ_CER_PAYEE_BANK_CODE                 "PBC"
  #define _DOMAIN_REQ_CER_PAYEE_NAME                      "PN"
  #define _DOMAIN_REQ_CER_BANK_ACC                        "BA"
  #define _DOMAIN_REQ_CER_MAX_TRANSFER_LIMIT              "MTL"
  #define _DOMAIN_REQ_CER_CCY                             "C"
  #define _DOMAIN_REQ_CER_ID_TYPE                         "IT"
  #define _DOMAIN_REQ_CER_ID_CODE                         "IC"
  #define _DOMAIN_REQ_CER_MOBILE                          "M"
  #define _DOMAIN_REQ_CER_PAYEE_BANK_ID                   "PBI"
#define _DOMAIN_CMS_RESPONSE_CTS_EDDA_REQUEST             "PER"

#define _DOMAIN_CMS_REQUEST_CTS_EDDA_OTP_GENERATE         "REOG"
  #define _DOMAIN_REQ_EOG_CLIENT_ACC_CODE                 "CAC"
  #define _DOMAIN_REQ_EOG_SEND_MODE                       "SM"
  #define _DOMAIN_REQ_EOG_NOTIFICATION_TYPE               "NT"
  #define _DOMAIN_REQ_EOG_OTP_DESTINATION                 "OD"
#define _DOMAIN_CMS_RESPONSE_CTS_EDDA_OTP_GENERATE        "PEOG"
  #define _DOMAIN_RSP_EOG_CLIENT_ACC_CODE                 "CAC"
  #define _DOMAIN_RSP_EOG_OTP_TYPE                        "OT"
  #define _DOMAIN_RSP_EOG_OTP_DESTINATION                 "D"
  #define _DOMAIN_RSP_EOG_OTP_RESEND_INTERVAL             "RI"
  #define _DOMAIN_RSP_EOG_OTP_RANDOM_CODE                 "RC"

#define _DOMAIN_CMS_REQUEST_CTS_EDDA_OTP_VERIFY           "REOV"
  #define _DOMAIN_REQ_CEOV_CLIENT_ACC_CODE                "CAC"
  #define _DOMAIN_REQ_CEOV_RANDOM_CODE                    "RC"
  #define _DOMAIN_REQ_CEOV_OTP                            "O"
#define _DOMAIN_CMS_RESPONSE_CTS_EDDA_OTP_VALIDATE        "REOV"
  #define _DOMAIN_RSP_EOV_CLIENT_ACC_CODE                 "CAC"
  #define _DOMAIN_RSP_EOV_VERIFY_STRING                   "VS"

#define _DOMAIN_CMS_REQUEST_CTS_EDDA_CASH_IN              "RECI"
  #define _DOMAIN_REQ_ECI_CLIENT_ACC_CODE                 "CAC"
  #define _DOMAIN_REQ_ECI_PASSWORD                        "P"
  #define _DOMAIN_REQ_ECI_CCY                             "C"
  #define _DOMAIN_REQ_ECI_AMOUNT                          "A"
  #define _DOMAIN_REQ_ECI_REMARK                          "R"
  #define _DOMAIN_REQ_ECI_FX_TRANSFER                     "FT"
  #define _DOMAIN_REQ_ECI_DEPOSIT_METHOD                  "DM"
  #define _DOMAIN_REQ_ECI_CHEQUE_NO                       "CN"
  #define _DOMAIN_REQ_ECI_BANK_TIME                       "BT"
  #define _DOMAIN_REQ_ECI_TRAN_METHOD                     "TM"
  #define _DOMAIN_REQ_ECI_PAYEE_BANK_ACC                  "PBA"
  #define _DOMAIN_REQ_ECI_API_TRAN_ID                     "ATI"
#define _DOMAIN_CMS_RESPONSE_CTS_EDDA_CASH_IO             "PECI"
  #define _DOMAIN_RSP_ECI_CLIENT_ACC_CODE                 "CAC"
  #define _DOMAIN_RSP_ECI_CCY                             "C"
  #define _DOMAIN_RSP_ECI_AMOUNT                          "A"
  #define _DOMAIN_RSP_ECI_UNCLEARED_AMT                   "UA"
  #define _DOMAIN_RSP_ECI_RATE                            "R"
  #define _DOMAIN_RSP_ECI_TRAN_TYPE                       "TT"
  #define _DOMAIN_RSP_ECI_API_TRAN_ID                     "ATI"


#define _DOMAIN_REQ_CEEH_FROM_DATE                     "FD"
#define _DOMAIN_REQ_CEEH_TO_DATE                       "TD"

#define _DOMAIN_CMS_REQUEST_CTS_EDDA_REGISTE_HISTORY "RERH"
#define _DOMAIN_CMS_RESPONSE_CTS_EDDA_REGISTE_HISTORY "PERH"

#define _DOMAIN_CMS_RESPONSE_CTS_EDDA_CASH_IN "PECIN"

#pragma pack(pop)

#endif









