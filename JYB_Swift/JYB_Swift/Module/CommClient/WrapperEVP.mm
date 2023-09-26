
//#include "stdafx.h"
#include "WrapperEVP.h"
#include <openssl/evp.h>
#include <openssl/x509.h>
#import <cstring>



///////////////////////////////////////////////////////////////////////////////////////////////

STCWrapperEVP::STCWrapperEVP()
{
	memset( m_Key,	0, sizeof(m_Key) ) ;
	memset( m_Iv,	0, sizeof(m_Iv) ) ;

	EVP_CIPHER_CTX_init(&m_Ctx) ;
	
}

STCWrapperEVP::~STCWrapperEVP()
{
	EVP_CIPHER_CTX_cleanup(&m_Ctx) ;

}

BOOL STCWrapperEVP::GenKey( char* echoKey ) 
{
	char tmp[25] ;
	memset( tmp, 0, sizeof(tmp) ) ;

	for( int i=0;i<24;i++ )
	{		
		tmp[i] = abs(rand())%127+1 ;
	}
	//echoKey = tmp ;
	strcpy(echoKey, tmp);
	return TRUE ;
	
}

void STCWrapperEVP::ReInit()
{
	memset( m_Key,	0, sizeof(m_Key) ) ;
	memset( m_Iv,	0, sizeof(m_Iv) ) ;
}

BOOL STCWrapperEVP::SetKey( LPCSTR pKey ) 
{
	ReInit() ;
	if( pKey==NULL )
		return FALSE ;

	// 3desœÚ¡ø ÷ª“™8byte.
	int i=0;
	for(i=0;i<8;i++ )
	{
		m_Iv[i]=i ;
	}

	// 3des key“™ 24byte.
	int KeyLen = strlen(pKey) ;
	for( i=0;i<24;i++ )
	{
		m_Key[i] = (i<KeyLen) ? pKey[i] : i ;
	}

	return TRUE ;
	
}

BOOL   STCWrapperEVP::Encrpt( BYTE* pSrcBuf, int SrcSize, BYTE* pDestBuf, int& echoDestSize ) 
{
	if( pSrcBuf==NULL || SrcSize<=0 )
		return FALSE ;
	if( pDestBuf==NULL || echoDestSize<SrcSize+8 )
		return FALSE ;

	//CQILock qilock(&m_Lock) ;	// paul, 2010-4-4, add.

	/*
		”√dest3 º”√‹.
	*/

	int rv = EVP_EncryptInit_ex( &m_Ctx, EVP_des_ede3_cbc(), NULL, m_Key, m_Iv ) ;	
	if( rv!=1 )
	{
		return FALSE ;
	}

	int outl ;
	int outltmp ;
	rv = EVP_EncryptUpdate( &m_Ctx, pDestBuf, &outl, pSrcBuf, SrcSize ) ;
	if( rv!=1 )	
	{
		return FALSE ;
	}

	rv = EVP_EncryptFinal_ex( &m_Ctx,pDestBuf+outl,&outltmp );
	if( rv!=1 )
	{
		return FALSE ;
	}
	outl += outltmp ;
	
	echoDestSize = outl ;
	return TRUE ;

}

BOOL STCWrapperEVP::Decrpt( BYTE* pSrcBuf, int SrcSize, BYTE* pDestBuf, int& echoDestSize ) 
{
	if( pSrcBuf==NULL || SrcSize<=0 )
		return FALSE ;
	if( pDestBuf==NULL || echoDestSize<SrcSize )
		return FALSE ;

	//CQILock qilock(&m_Lock) ;	// paul, 2010-4-4, add.


	int rv = EVP_DecryptInit_ex( &m_Ctx, EVP_des_ede3_cbc(), NULL, m_Key, m_Iv ) ;
	if( rv!=1 )
	{
		return FALSE ;
	}
	
	int outl ;
	int outltmp ;
	rv = EVP_DecryptUpdate( &m_Ctx, pDestBuf, &outl, pSrcBuf, SrcSize ) ;
	if( rv!=1 )	
	{
		return FALSE ;
	}

	rv = EVP_DecryptFinal_ex( &m_Ctx, pDestBuf+outl,&outltmp );
	if( rv!=1 )
	{
		return FALSE ;
	}
	outl += outltmp ;

	echoDestSize = outl ;
	return TRUE ;

}





//////////////////////////////////////////////256长度的加密/////////////////////////////////////////////////

STCWrapperAES::STCWrapperAES()
{
    memset(m_Key, 0, sizeof(m_Key));
    memset(m_Iv,  0, sizeof(m_Iv));
    
    EVP_CIPHER_CTX_init(&m_Ctx);
}

STCWrapperAES::~STCWrapperAES()
{
    EVP_CIPHER_CTX_cleanup(&m_Ctx);
}




BOOL STCWrapperAES::GenKey( char* echoKey )
{
    char tmp[EVP_MAX_KEY_LENGTH + 1] ;
    memset( tmp, 0, sizeof(tmp) ) ;
    
    for(int i = 0; i < 32; ++i)
    {
        tmp[i] = abs(rand())%127+1 ;
    }
    strcpy(echoKey, tmp);
    
    return TRUE ;
}

void STCWrapperAES::ReInit()
{
    memset(m_Key, 0, sizeof(m_Key));
    memset(m_Iv,  0, sizeof(m_Iv));
}

BOOL STCWrapperAES::SetKey( LPCSTR pKey )
{
    ReInit() ;
    if( pKey==NULL )
        return FALSE ;
    
    // aes向量 只要16byte.
    int i;
    for(i = 0; i < 16; ++i)
    {
        m_Iv[i] = i;
    }
    
    // ades256 key要 32byte.
    int KeyLen = strlen(pKey);
    for(i = 0; i < 32; ++i)
    {
        m_Key[i] = (i < KeyLen) ? pKey[i] : i ;
    }
    
    return TRUE ;
}

BOOL STCWrapperAES::SetRawKey( LPCSTR pKey )
{
    ReInit() ;
    if( pKey==NULL )
        return FALSE ;
    
    int KeyLen = strlen(pKey);
    int i = 0;
    while(i < EVP_MAX_KEY_LENGTH)
    {
        if (i < KeyLen && i < EVP_MAX_IV_LENGTH)
            m_Iv[i] = pKey[i];
        if (i < KeyLen && i < EVP_MAX_KEY_LENGTH)
            m_Key[i] = pKey[i];
        ++i;
    }
    
    return TRUE ;
}

BOOL STCWrapperAES::Encrpt( BYTE* pSrcBuf, int SrcSize, BYTE* pDestBuf, int& echoDestSize )
{
    if( pSrcBuf == NULL || SrcSize <= 0 )
        return FALSE;
    if( pDestBuf == NULL || echoDestSize <= 0 )
        return FALSE;
   
    
    // 指定加密算法和密钥
    int rv = EVP_EncryptInit_ex( &m_Ctx, EVP_aes_256_cbc(), NULL, m_Key, m_Iv ) ;
    if( rv != 1 )
    {
        return FALSE ;
    }
    
    int nLen, nExLen;
    rv = EVP_EncryptUpdate( &m_Ctx, pDestBuf, &nLen, pSrcBuf, SrcSize ) ;
    if( rv != 1 )
    {
        return FALSE ;
    }
    
    rv = EVP_EncryptFinal_ex( &m_Ctx, pDestBuf + nLen, &nExLen );
    if( rv != 1 )
    {
        return FALSE ;
    }
    nLen += nExLen ;
    echoDestSize = nLen ;
    
    return TRUE ;
}

BOOL STCWrapperAES::Decrpt( BYTE* pSrcBuf, int SrcSize, BYTE* pDestBuf, int& echoDestSize )
{
    if( pSrcBuf == NULL || SrcSize <= 0 )
        return FALSE;
    if( pDestBuf == NULL || echoDestSize <= 0 )
        return FALSE;
    

    // 指定加密算法和密钥
    int rv = EVP_DecryptInit_ex( &m_Ctx, EVP_aes_256_cbc(), NULL, m_Key, m_Iv ) ;
    if( rv != 1 )
    {
        return FALSE ;
    }
    
    int nLen, nExLen;
    rv = EVP_DecryptUpdate( &m_Ctx, pDestBuf, &nLen, pSrcBuf, SrcSize ) ;
    if( rv != 1 )
    {
        return FALSE ;
    }
    
    rv = EVP_DecryptFinal_ex( &m_Ctx, pDestBuf + nLen, &nExLen );
    if( rv != 1 )
    {
        return FALSE ;
    }
    nLen += nExLen ;
    echoDestSize = nLen ;
    
    return TRUE ;
}
