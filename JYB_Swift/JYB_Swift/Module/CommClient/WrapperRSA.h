
/*
	∂‘openssl RSAÀ„∑®µƒ∑‚◊∞

	RSAÀ„∑®ª˘¥°÷™ ∂:

		RSAÀ„∑® «”… Rivest,Shamir∫ÕAdleman‘⁄1978ƒÍÃ·≥ˆ∑¢“ª÷÷π´≥◊√‹¬ÎÀ„∑®.
		RSAÀ„∑® «µ⁄“ª∏ˆ…Ëº∆ÕÍ…∆µƒπ´≥◊√‹¬ÎÀ„∑®. ∏√À„∑®µƒ ˝—ßª˘¥° «Euler∂®¿Ì, ≤¢Ω®¡¢‘⁄¥Û’˚ ˝∑÷Ω‚¿ßƒ—–‘÷Æ…œ.
		º¥: Ω´¡Ω∏ˆ¥ÛÀÿ ˝≥À∆¿¥…œœ‡∂‘»›“◊µƒ, ∂¯∑÷Ω‚¡Ω∏ˆ¥ÛÀÿ ˝µƒª˝ «º∆À„…œ≤ªø…––µƒ.

    RSAÀ„∑®√Ë ˆ:

		√‹≥◊…˙≥…:

			’“¡Ω∏ˆÀÊª˙µƒ¥ÛÀÿ ˝p∫Õq, º∆À„n=pq ∫Õ f(n)=(p-1)(q-1) ;
			—°‘ÒÀÊª˙ ˝e(“ª∞„”√0x10001), ¬˙◊„e”Î f(n)ª•Àÿ.
			
			º∆À„ d = exp( e, -1 ) mod f(n)
			
			π´≥◊£∫ (n,e)
			ÀΩ≥◊£∫ (n,d,p,q)	//  µº  (n,e,d)“≤∂ºø…“‘.
			
	ƒø«∞nµƒ”––ß≥§∂» «1024bit «∞≤»´µƒ, Ω®“È2048bit.
	
	 ˝æ›ÃÓ≥‰Œ Ã‚:
	
		±Í◊ºÃÓ≥‰”–PKCS1 ∫Õ PSS.
		»Áπ˚1024bit(128byte), ‘Ú√ø¥Œº”√‹‘ÀÀ„◊Ó∂‡¥¶¿Ì117◊÷Ω⁄.

*/

#ifndef _WRAPPERRSA_H_
#define	_WRAPPERRSA_H_

//#include <afxtempl.h>
#include <openssl/rsa.h>

#import <Foundation/Foundation.h>
#import "StandDataType.h"


class STCWrapperOpenSSL
{
public:

/*
	opensslµƒ≥ı ºªØ∂Ø◊˜.
*/
	static void Init() ;

/*
	opensslµƒΩ· ¯«Â≥˝∂Ø◊˜.
*/
	static void Cleanup() ;


};


class STCWrapperRSA
{  
public:
	STCWrapperRSA() ;
	~STCWrapperRSA() ;

	void ReInit() ;

/*
	≥ı ‘ªØ public key.
*/
	BOOL InitPublicKey( LPCSTR pN, LPCSTR pE ) ;

/*
	≥ı ‘ªØ private key.
*/
	BOOL InitPrivateKey( LPCSTR pN, LPCSTR pE, LPCSTR pD ) ;

/*
	≤˙…˙“ª∏ˆ BitLengthŒªµƒ key.

	π´≥◊£∫ (n,e)					// 16Ω¯÷∆string	
	ÀΩ≥◊£∫ (n,e,d)					// 16Ω¯÷∆string	

*/
	BOOL GenKey( char *echoN, char * echoE, char *echoD, int BitLength = 1024 ) ;

/*
	(”√π´≥◊)º”√‹.
*/
	BOOL   Encrpt( BYTE* pSrcBuf, int SrcSize, BYTE* pDestBuf, int& echoDestSize ) ;


/*
	(”√ÀΩ≥◊)Ω‚√‹.
*/
	BOOL   Decrpt( BYTE* pSrcBuf, int SrcSize, BYTE* pDestBuf, int& echoDestSize ) ;

/*
	≤È—Ø‘≠◊”∞¸µƒ¥Û–°.
*/
	int	   QueryAtomSize() ; 	

/*
	≤È—Ø ø€≥˝ÃÓ≥‰≤ø∑÷ µƒ¥Û–°.
*/
	int	   QueryAtomSize_SubPadding() ; 	

public:

	RSA*	m_pKey ;


};



#endif 
