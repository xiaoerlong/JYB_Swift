
#include "ClientSecurityMng.h"
#include <pthread.h>
static pthread_mutex_t RSA_pLock;
STCClientSecurityMng::STCClientSecurityMng()
{
    char n[] = "BB8DAFD0D62ACA2B66D64AB55B100526F0C86D48B25FABDDBF2AB5C6F66732185823A9BE2A6B6C1D1657C42FEAC9770B468D99BDAED0A038B4F3E20D31D721FC0FCA25D9438D5E0698553A932B116170CFA1C4EEC5F5D64BAC14B1ADF9AEE9668547FBD5644DA15AE8B0FA45ECBDF40FFBE5072F0804BCEBA4FD5F444A8C227D" ;
    char e[] = "010001" ;
    
    m_RSA.InitPublicKey( n,e ) ;
    
//    m_lock = [[NSCondition alloc] init];
//    [m_lock setName:@"communicator_lock"];
      pthread_mutex_init(&RSA_pLock, NULL);

}

 
STCClientSecurityMng::~STCClientSecurityMng()
{
//    [m_lock release];
//    m_lock =nil;
  
}

//void STCClientSecurityMng::Lock()
//{
////    m_lock = [[NSRecursiveLock alloc] init];
////    [m_lock setName:@"communicator_lock1"];
//    [m_lock lock] ;
//    
//
//    
//}
//void STCClientSecurityMng::UnLock()
//{
//    [m_lock unlock] ;
////    [m_lock release];
//}

void STCClientSecurityMng::ReInit()
{
}

BOOL STCClientSecurityMng::Encrypt_RSA( BYTE* pSrcBuf, int SrcBufSize, BYTE* pDestBuf, int& echoDestSize )
{
    
    /*
     Œ¥÷™openssl÷– API «∑Òœﬂ≥Ã∞≤»´, º”À¯±£ª§.
     */
    
//    Lock() ;
    
  
    pthread_mutex_lock(&RSA_pLock);
    /*BOOL ret = */m_RSA.Encrpt( pSrcBuf, SrcBufSize, pDestBuf, echoDestSize ) ;
//    UnLock() ;
    pthread_mutex_unlock(&RSA_pLock);
    return TRUE ;
    
}

BOOL STCClientSecurityMng::Encrypt( BYTE* pSrcBuf, int SrcBufSize, BYTE* pDestBuf, int& echoDestSize )
{
    
    /*
     Œ¥÷™openssl÷– API «∑Òœﬂ≥Ã∞≤»´, º”À¯±£ª§.
     */
    
    
    //改成局部锁
  
    pthread_mutex_lock(&RSA_pLock);
//    Lock() ;
    /*BOOL ret = */m_EVP.Encrpt( pSrcBuf, SrcBufSize, pDestBuf, echoDestSize ) ;
//    UnLock() ;
    
    pthread_mutex_unlock(&RSA_pLock);

    return TRUE ;
    
}

 BOOL STCClientSecurityMng::Decrypt(  BYTE* pSrcBuf, int SrcBufSize, BYTE* pDestBuf, int& echoDestSize )
 {
 
     
   
     pthread_mutex_lock(&RSA_pLock);
// Lock() ;
 BOOL ret = m_EVP.Decrpt( pSrcBuf, SrcBufSize, pDestBuf, echoDestSize ) ;
// UnLock() ;
     pthread_mutex_unlock(&RSA_pLock);
 return TRUE ;
 
 }


BOOL STCClientSecurityMng::Encrypt_AES( BYTE* pSrcBuf, int SrcBufSize, BYTE* pDestBuf, int& echoDestSize )
{
    
    /*
     Œ¥÷™openssl÷– API «∑Òœﬂ≥Ã∞≤»´, º”À¯±£ª§.
     */
    
//    Lock() ;
    
  
    pthread_mutex_lock(&RSA_pLock);
    /*BOOL ret = */m_AES.Encrpt( pSrcBuf, SrcBufSize, pDestBuf, echoDestSize ) ;
//    UnLock() ;
    pthread_mutex_unlock(&RSA_pLock);
    return TRUE ;
    
}
BOOL STCClientSecurityMng::Decrypt_AES(  BYTE* pSrcBuf, int SrcBufSize, BYTE* pDestBuf, int& echoDestSize )
{
    
    
  
    pthread_mutex_lock(&RSA_pLock);
//    Lock() ;
    BOOL ret = m_AES.Decrpt( pSrcBuf, SrcBufSize, pDestBuf, echoDestSize ) ;
//    UnLock() ;
    pthread_mutex_unlock(&RSA_pLock);
    return TRUE ;
    
}



/////////////////////////新的扩展加密///////////////////////////////////////////////////////////////



STCClientSecurityMng::STCClientSecurityMng( int type)
{
    char n[] = "D237D1BEEC2692DC0EAE3F11C086F73F5C37C6692C6570FC571D002AF1D5DBA6A862F92904D98ABF640261B03E678C8135F29752AA0B19965E53021BD9008784CDE1EC1165537CF062B059E702CEE733F3A9785C4D9E2EF9D00AE0C3DF5F77A29B6D700C48C6608502C8AFBC24AD46DC77307F4B9834E0BB1C0DAE1ADD9E40CD6C223B39C7953C7717DF2E9E390E7912484E7431F6C547F5E2E10D511D98720C5BD5EC36587B0C1E00ADEAC600FCF956D1CD906548085186F865B6A1AFE570524A0E43D571DC23589F122357BFC726FBCCA01FA6414F836505B262C269D47DE9DF5AEFC3FE1F2AE29495BB4085B6F7B8EDCA43900F1773D1F2A70A513F8E350F";
    
    char e[] = "010001" ;
    
    m_RSA.InitPublicKey( n,e ) ;
    
//    m_lock = [[NSCondition alloc] init];
//    [m_lock setName:@"communicator_lock"];
    
}


STCClientSecurityMng::STCClientSecurityMng( LPCSTR n,LPCSTR e)
{
    m_RSA.InitPublicKey( n,e ) ;
//    m_lock = [[NSCondition alloc] init];
//    [m_lock setName:@"communicator_lock"];
}

STCClientSecurityMng::STCClientSecurityMng( LPCSTR n,LPCSTR e,LPCSTR d)
{
    m_RSA.InitPrivateKey( n,e ,d) ;

}


















