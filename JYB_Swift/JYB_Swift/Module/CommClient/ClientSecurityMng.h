///////////////////////////////////////////////////////////////////////////
//
//    Cleint∂À∞≤»´π‹¿Ìµƒ∂‘œÛ.
//
//
//
///////////////////////////////////////////////////////////////////////////

#ifndef _CLIENTSECURITYMNG_H_
#define _CLIENTSECURITYMNG_H_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000


#include "WrapperRSA.h"
//#include "..\..\server\include\lock.h"
#include "WrapperEVP.h"
#include "MarketDataProtocol_CMS.h"

#pragma  pack (push,1)


class STCClientSecurityMng
{
public:
    STCClientSecurityMng() ;
    STCClientSecurityMng( int type);//tiger 2017
    ~STCClientSecurityMng() ;
    STCClientSecurityMng(LPCSTR n,LPCSTR e);
    STCClientSecurityMng( LPCSTR n,LPCSTR e,LPCSTR d);
    void ReInit() ;

//    void Lock() ;
//    void UnLock() ;

/*
    RSA”√ π´≥◊º”√‹.
*/
    BOOL Encrypt_RSA( BYTE* pSrcBuf, int SrcBufSize, BYTE* pDestBuf, int& echoDestSize ) ;

/*
    ”√ 3DesÀ„∑®º”√‹.
*/
    BOOL Encrypt( BYTE* pSrcBuf, int SrcBufSize, BYTE* pDestBuf, int& echoDestSize ) ;
    BOOL Decrypt( BYTE* pSrcBuf, int SrcBufSize, BYTE* pDestBuf, int& echoDestSize );

    
    BOOL Encrypt_AES( BYTE* pSrcBuf, int SrcBufSize, BYTE* pDestBuf, int& echoDestSize );
    BOOL Decrypt_AES(  BYTE* pSrcBuf, int SrcBufSize, BYTE* pDestBuf, int& echoDestSize );
public:
    STCWrapperRSA        m_RSA ;        // RSAº”√‹∂‘œÛ.
    STCWrapperEVP        m_EVP ;        // 3Desº”√‹∂‘œÛ.
    STCWrapperAES       m_AES ;
    
    CHALLENGE_INFO    m_ChallengeInfo ;    // ÃÙ’Ω–≈œ¢.
    CHALLENGE_INFO_AES m_ChallengeInfo_AES;

private:
//    NSCondition        *m_lock ;

};

#pragma pack(pop)
#endif
