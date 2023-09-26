
//#include "stdafx.h"
#include "WrapperRSA.h"
#include <openssl/evp.h>
#include <openssl/x509.h>

/*#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif*/

void STCWrapperOpenSSL::Init()
{
	srand( (unsigned)time( NULL ) );

	OpenSSL_add_all_digests() ;
	OpenSSL_add_all_algorithms() ;
	OpenSSL_add_all_ciphers() ;

}

void STCWrapperOpenSSL::Cleanup()
{
	CRYPTO_cleanup_all_ex_data();	// »Áπ˚√ª”–’‚∏ˆ, RSA_free()”––©ƒ⁄»›≤ªƒ‹ÕÍ»´ Õ∑≈.
	EVP_cleanup() ;
	
}


///////////////////////////////////////////////////////////////////////////////////////////////

STCWrapperRSA::STCWrapperRSA()
{
	m_pKey = NULL ;
}

STCWrapperRSA::~STCWrapperRSA()
{
	ReInit() ;
	
}

void STCWrapperRSA::ReInit()
{
	if( m_pKey!=NULL )
	{
//	    RSA_free(m_pKey);
		m_pKey = NULL ;
	}

}

BOOL STCWrapperRSA::InitPublicKey( LPCSTR pN, LPCSTR pE )
{
	if( pN==NULL || pE==NULL )
		return FALSE ;

	ReInit() ;

    BIGNUM *bnn, *bne ;
    bnn = BN_new();
    bne = BN_new();
    BN_hex2bn( &bnn, pN );
    BN_hex2bn( &bne, pE );
	//BN_set_word(bne, RSA_F4);

	m_pKey = RSA_new() ;
    m_pKey->n = bnn;
    m_pKey->e = bne;
	
	return TRUE ;

}

BOOL STCWrapperRSA::InitPrivateKey( LPCSTR pN, LPCSTR pE, LPCSTR pD ) 
{
	if( pN==NULL || pE==NULL || pD==NULL )
		return FALSE ;

	ReInit() ;

    BIGNUM *bnn, *bne, *bnd ;
    bnn = BN_new();
    bne = BN_new();
    bnd = BN_new();
    BN_hex2bn( &bnn, pN );
    BN_hex2bn( &bne, pE );
	//BN_set_word(bne, RSA_F4);
    BN_hex2bn( &bnd, pD );

	m_pKey = RSA_new() ;
    m_pKey->n = bnn;
    m_pKey->e = bne;
    m_pKey->d = bnd;
	
	return TRUE ;

}


 BOOL STCWrapperRSA::GenKey( char * echoN, char * echoE, char *echoD, int BitLength ) 
{

/*	
	æØ∏Ê: openssl÷– RSA_generate_key()”–«·Œ¢ƒ⁄¥Ê–π¬∂.
	
	“…Œ :	
		  ø¥opensslŒƒµµ, ÀµRSA_generate_key()÷Æ«∞“™≥ı ‘ªØ ÀÊª˙ ˝÷÷◊”, Œ¥«Â≥˛openssl÷– »Á∫Œ≥ı ‘ªØÀÊª˙ ˝÷÷◊”.

*/

	RSA* r = NULL ;
	r = RSA_generate_key( BitLength, RSA_F4, NULL, NULL ) ;
	if( r==NULL )
		return FALSE ;
	
	char* pN =  BN_bn2hex( r->n ) ;
	char* pE =  BN_bn2hex( r->e ) ;
	char* pD =  BN_bn2hex( r->d ) ;
	assert( pN!=NULL && pE!=NULL && pD!=NULL ) ;

	BOOL error = FALSE ;
	if( pN==NULL || pE==NULL || pD==NULL )
	{
		error = TRUE ;
		goto ErrorExit ;
	}

	echoN = pN ; 
	echoE = pE ;
	echoD = pD ;

	OPENSSL_free(pN) ;
	OPENSSL_free(pE) ;
	OPENSSL_free(pD) ;
    RSA_free(r);
	return TRUE ;

ErrorExit:	

	if( pN!=NULL )
	{
		OPENSSL_free(pN) ;
	}
	if( pE!=NULL )
	{
		OPENSSL_free(pE) ;
	}
	if( pD!=NULL )
	{
		OPENSSL_free(pD) ;
	}
    RSA_free(r);
	return FALSE ;	

}

int	 STCWrapperRSA::QueryAtomSize()
{
	if( m_pKey==NULL )
//		return 0 ;
    return 128;
	return  RSA_size(m_pKey); 

}

int	 STCWrapperRSA::QueryAtomSize_SubPadding()
{
	// ÷ª÷ß≥÷RSA_PKCS1_PADDING∑Ω ΩÃÓ≥‰.
	return  QueryAtomSize()-11 ;

}

BOOL   STCWrapperRSA::Encrpt( BYTE* pSrcBuf, int SrcSize, BYTE* pDestBuf, int& echoDestSize ) 
{
	if( m_pKey==NULL )
		return FALSE ;
	if( pSrcBuf==NULL || SrcSize<=0 )
		return FALSE ;
	if( pDestBuf==NULL || echoDestSize<=0 )
		return FALSE ;

	int	AtomSize = QueryAtomSize() ;
	if( AtomSize<=0 )
		return FALSE ;
	int SrcAtomSize = QueryAtomSize_SubPadding() ;
	if( SrcAtomSize<=0 )
		return FALSE ;

	div_t div_result;
	div_result = div( SrcSize, SrcAtomSize );
	int MinDestSize = AtomSize*div_result.quot ;
	if( div_result.rem>0 )
	{
		MinDestSize += AtomSize ;
	}
	if( echoDestSize<MinDestSize )
		return FALSE ;

	int PackSize	= 0 ;		// “—æ≠º”√‹µƒ √˜Œƒ≥§∂».
	int EncryptSize = 0 ;		// “—æ≠…˙≥…µƒ √‹Œƒ≥§∂».
	while( PackSize<SrcSize )
	{
		int ps = SrcSize-PackSize;
		if(ps > SrcAtomSize)
			ps = SrcAtomSize;
		//min( SrcAtomSize, SrcSize-PackSize ) ;
	    int ret = RSA_public_encrypt( ps, pSrcBuf+PackSize, pDestBuf+EncryptSize, m_pKey,  RSA_PKCS1_PADDING );
		if( ret<=0 || ret!=AtomSize )
			return FALSE ;

		PackSize += ps ;
		EncryptSize += ret ;
	}
	echoDestSize = EncryptSize ;
	return TRUE ;

}

BOOL STCWrapperRSA::Decrpt( BYTE* pSrcBuf, int SrcSize, BYTE* pDestBuf, int& echoDestSize ) 
{
	if( m_pKey==NULL )
		return FALSE ;
	if( pSrcBuf==NULL || SrcSize<=0 )
		return FALSE ;
	if( pDestBuf==NULL || echoDestSize<=0 )
		return FALSE ;

	int	AtomSize = QueryAtomSize() ;
	if( AtomSize<=0 )
		return FALSE ;
	if( SrcSize<AtomSize )
		return FALSE ;

	div_t div_result ;
	div_result = div( SrcSize, AtomSize );
	int MinDestSize = AtomSize*div_result.quot ;
	if( div_result.rem!=0 )
	{
		return FALSE ;
	}
	if( echoDestSize<MinDestSize )
		return FALSE ;

	int PackSize	= 0 ;		// “—æ≠Ω‚√‹µƒ √‹Œƒ≥§∂».
	int DecryptSize = 0 ;		// “—æ≠…˙≥…µƒ √˜Œƒ≥§∂».
	while( PackSize<SrcSize )
	{
		int ps = AtomSize ;
	    int ret = RSA_private_decrypt( ps, pSrcBuf+PackSize, pDestBuf+DecryptSize, m_pKey,  RSA_PKCS1_PADDING );
		if( ret<=0 )
			return FALSE ;

		PackSize += ps ;
		DecryptSize += ret ;
	}
	
	echoDestSize = DecryptSize ;
	return TRUE ;

}
