
/*
	∂‘openssl ∂‘≥∆º”√‹À„∑®≤ø∑÷∑‚◊∞( EVP )

		µ‰–Õµƒ∂‘≥∆º”√‹À„∑®∞¸¿®: DES, 3DES, AES, IDEA

	±æŒƒ÷˜“™∂‘ 3DES µœ÷∑‚◊∞.	

	3DESÀ„∑®√Ë ˆ:

		1. key « 24byte.
				
		2. º”√‹ ±∫Ú, 

			√˜Œƒ≥§∂»Œ™m, ‘Ú√‹Œƒ≥§∂»Œ™ (m/8)*8+8 .

		   æÕ «»Áπ˚∏’∫√’˚≥˝8, ‘Ú∫Û√Ê”–8∏ˆÃÓ≥‰◊÷Ω⁄. “Ú¥À √‹Œƒ≥§∂»Œ™ m+8 «∞≤»´µƒ.
		   
*/

#ifndef _WRAPPEREVP_H_
#define	_WRAPPEREVP_H_

#import <Foundation/Foundation.h>
#import "StandDataType.h"

//#include <afxtempl.h>
#include <openssl/evp.h>
//#include "lock.h"

//#pragma pack(1)

//#pragma pack(8)

class STCWrapperEVP
{
public:
    STCWrapperEVP() ;
    ~STCWrapperEVP() ;

    void ReInit() ;

/*
    ≤˙…˙“ª∏ˆkey.
*/
    static BOOL GenKey( char *echoKey ) ;

/*
    …Ë÷√key.
*/
    BOOL SetKey( LPCSTR pKey ) ;

/*
    º”√‹.
*/
    BOOL   Encrpt( BYTE* pSrcBuf, int SrcSize, BYTE* pDestBuf, int& echoDestSize ) ;

/*
    Ω‚√‹.
*/
    BOOL   Decrpt( BYTE* pSrcBuf, int SrcSize, BYTE* pDestBuf, int& echoDestSize ) ;


public:

    unsigned char    m_Key[EVP_MAX_KEY_LENGTH] ;        // √‹≥◊
    unsigned char    m_Iv[EVP_MAX_KEY_LENGTH] ;        // ≥ı ºªØœÚ¡ø
    EVP_CIPHER_CTX    m_Ctx ;                            // EVPÀ„∑®…œœ¬Œƒ
    
    //CAutoLock        m_Lock ;    // paul, 2010-4-4, add.

};

class STCWrapperAES
{
public:
    STCWrapperAES();
    ~STCWrapperAES();
    
    static BOOL GenKey( char *echoKey ) ;
    
    void ReInit();
    
    BOOL SetKey( LPCSTR pKey );
    BOOL SetRawKey( LPCSTR pKey );
    
    BOOL Encrpt( BYTE* pSrcBuf, int SrcSize, BYTE* pDestBuf, int& echoDestSize );
    
    BOOL Decrpt( BYTE* pSrcBuf, int SrcSize, BYTE* pDestBuf, int& echoDestSize );
    
public:
    unsigned char    m_Key[EVP_MAX_KEY_LENGTH];    // √‹≥◊
    unsigned char    m_Iv[EVP_MAX_IV_LENGTH];    // ≥ı ºªØœÚ¡ø
    EVP_CIPHER_CTX    m_Ctx;                        // EVPÀ„∑®…œœ¬Œƒ
    
    //CAutoLock        m_Lock;
};


#endif 
