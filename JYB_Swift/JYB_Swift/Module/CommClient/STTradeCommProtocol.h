//
//  STTradeCommProtocol.h
//  SMX
//
//  Created by steven on 10-11-26.
//  Copyright 2010 tsci. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark -
#pragma mark common error

#define STTRADE_ERROR_Unknown				(-99101)
#define STTRADE_ERROR_ServerNotConnect		(-99112)//(-99102)
#define STTRADE_ERROR_PackageError			(-99103)
#define STTRADE_ERROR_SendError				(-99104)
#define STTRADE_ERROR_WaitOvertime			(-99105)
#define STTRADE_ERROR_NotLogin				(-99106)
#define STTRADE_ERROR_CommNotExsit			(-99107)
#define STTRADE_ERROR_TranslatorNotExsit	(-99108)
#define STTRADE_ERROR_ParsePackageError		(-99109)
#define STTRADE_ERROR_ReadResponseError		(-99110)
#define STTRADE_ERROR_WriteRequestError		(-99111)
#define STTRADE_ERROR_ServerDisconnect		(-99112)

#define STTRADE_ERROR_NO_ERROR                (-99113)
//add 2017.02.24 万海错误代码中英文对照表
#define STTRADE_ERROR_AmendmentOrderNotExist_ERROR                   (1000)
#define STTRADE_ERROR_DatabaseDeadlock_ERROR                          (1205)
#define STTRADE_ERROR_ItemAlreadyExists_ERROR                           (2627)
#define STTRADE_ERROR_DealerPersonalOrderList_ERROR                      (2801)
#define STTRADE_ERROR_CannotOpenDatabaseRequested_ERROR               (4060)
#define STTRADE_ERROR_ProductTypeNotValid_ERROR                        (6002)
#define STTRADE_ERROR_ClientCodeNotValid_ERROR                          (6003)
#define STTRADE_ERROR_PriceNotValid_ERROR                          (6004)
#define STTRADE_ERROR_QuantityNotValid_ERROR                           (6005)
#define STTRADE_ERROR_InstrumentNotValid_ERROR                          (6006)
#define STTRADE_ERROR_QuantityMustBeMultipleOrLessThanLotSize_ERROR     (6007)
#define STTRADE_ERROR_InstrumentMustBeEnteredFirst_ERROR                (6008)
#define STTRADE_ERROR_ThisOrderIsReversedOrCanceled_ERROR               (6009)
#define STTRADE_ERROR_ActionCannotBePerformed_ERROR                    (6010)
#define STTRADE_ERROR_TotalQuantityLargerThanOrderQuantity_ERROR                    (6011)
#define STTRADE_ERROR_InvalidDataType_ERROR                             (6012)
#define STTRADE_ERROR_ValueMustBeLargerThanZero_ERROR                  (6013)
#define STTRADE_ERROR_NewValueIsInvalid_ERROR                           (6014)
#define STTRADE_ERROR_NoQuantityLeft_ERROR                              (6015)
#define STTRADE_ERROR_ApprovedOrRejectedRecordCanNotBeChanged_ERROR   (6016)
#define STTRADE_ERROR_NumericValueRequired_ERROR                       (6017)
#define STTRADE_ERROR_QuantityMustBeGreaterThanZero_ERROR              (6018)
#define STTRADE_ERROR_InvalidSelection_ERROR                             (6019)
#define STTRADE_ERROR_AllFieldsMustBeEntered_ERROR                      (6020)
#define STTRADE_ERROR_UserIDNotValid_ERROR                              (6021)
#define STTRADE_ERROR_PasswordNotConfirmedCorrectly_ERROR              (6022)
#define STTRADE_ERROR_PasswordNotEntered_ERROR                         (6023)
#define STTRADE_ERROR_LicensePasswordIncorrect_ERROR                    (6024)
#define STTRADE_ERROR_HaveExceededLicencesForPurchased_ERROR           (6025)
#define STTRADE_ERROR_ThisUserIsAlreadyLoggedOn_ERROR                  (6026)
#define STTRADE_ERROR_PriceIsBeyondDefinedLimits_ERROR                     (6027)
#define STTRADE_ERROR_DateForOrderValidityIsNotValid_ERROR              (6028)
#define STTRADE_ERROR_PriceQuote_ERROR                                 (6029)
#define STTRADE_ERROR_BestFivePrice_ERROR                               (6030)
#define STTRADE_ERROR_PriceInformation_ERROR                           (6031)
#define STTRADE_ERROR_OrderQueueingPosition_ERROR                     (6032)
#define STTRADE_ERROR_MarketMessage_ERROR                           (6035)
#define STTRADE_ERROR_DepotNotValid_ERROR                           (6036)
#define STTRADE_ERROR_AcctTypeNotValid_ERROR                        (6037)
#define STTRADE_ERROR_CCYNotValid_ERROR                             (6039)
#define STTRADE_ERROR_QtyExceedLONGDataType_ERROR                   (6040)
#define STTRADE_ERROR_BankNoNotValid_ERROR                          (6042)
#define STTRADE_ERROR_LanguageNotValid_ERROR                        (6045)
#define STTRADE_ERROR_SettledOrderNoNotValid_ERROR                (6046)
#define STTRADE_ERROR_PasswordIsToShort_ERROR                (6048)
#define STTRADE_ERROR_AECodeNotValid_ERROR                (6051)
#define STTRADE_ERROR_WorkGroupNotValid_ERROR                (6052)
#define STTRADE_ERROR_MarketNotValid_ERROR                (6053)
#define STTRADE_ERROR_TotalAmountExcessInputAmount_ERROR    (6054)
#define STTRADE_ERROR_ContactTypeIsMissingOrInvalid_ERROR          (6055)
#define STTRADE_ERROR_RebateTypeIsMissingOrInvalid_ERROR           (6056)
#define STTRADE_ERROR_RebateCalculationMethodIsMissingOrInvalid_ERROR  (6057)
#define STTRADE_ERROR_RebateAccountIsMissingOrInvalid_ERROR         (6058)
#define STTRADE_ERROR_BankAccountIsMissingOrInvalid_ERROR           (6059)
#define STTRADE_ERROR_SettlementMethodIsMissingOrInvalid_ERROR     (6060)
#define STTRADE_ERROR_ClientGroupIsMissingOrInvalid_ERROR            (6061)
#define STTRADE_ERROR_BalanceStatusIsMissingOrInvalid_ERROR            (6062)
#define STTRADE_ERROR_ClientNameIsMissing_ERROR                (6063)
#define STTRADE_ERROR_AccountNatureIsMissingOrInvalid_ERROR        (6064)
#define STTRADE_ERROR_InvalidConfirmationInstruction_ERROR          (6065)
#define STTRADE_ERROR_InvalidChequeNo_ERROR                         (6066)
#define STTRADE_ERROR_ChequePrintNotAllowed_ERROR                (6067)
#define STTRADE_ERROR_InstrumentClassIsMissing_ERROR                (6068)
#define STTRADE_ERROR_ShortSellNotAllowed_ERROR                (6069)
#define STTRADE_ERROR_GLCodeIsMissing_ERROR                (6070)
#define STTRADE_ERROR_InstrumentCategoryIsMissing_ERROR                (6072)
#define STTRADE_ERROR_InvalidDateFormat_ERROR                (6073)
#define STTRADE_ERROR_RateNotValid_ERROR                (6074)
#define STTRADE_ERROR_CalculationPeriodNotValid_ERROR                (6075)
#define STTRADE_ERROR_ReferenceNumberNotValid_ERROR                (6077)
#define STTRADE_ERROR_ValueDateBeforeConfirmationDate_ERROR         (6078)
#define STTRADE_ERROR_AssociatedAccountIsInvalid_ERROR                (6079)
#define STTRADE_ERROR_PercentageOverHundred_ERROR                (6080)
#define STTRADE_ERROR_MarginPercentIsMissing_ERROR                (6081)
#define STTRADE_ERROR_InvalidPriority_ERROR                (6090)
#define STTRADE_ERROR_DescriptionIsMissing_ERROR                (6095)
#define STTRADE_ERROR_SettlementMethodCodeIsMissing_ERROR          (6096)
#define STTRADE_ERROR_StatusIsNotValid_ERROR                (6099)
#define STTRADE_ERROR_ValueIsNotValid_ERROR                (6101)
#define STTRADE_ERROR_NoSuchPreprocess_ERROR                (6104)
#define STTRADE_ERROR_ProductNotValid_ERROR                (6109)
#define STTRADE_ERROR_PriceLotAndOrVolumnWarningExceeded_ERROR     (6100)
#define STTRADE_ERROR_PriceLotAndOrVolumnRestrictionExceeded_ERROR      (6111)
#define STTRADE_ERROR_InvalidDealerCode_ERROR                (6201)
#define STTRADE_ERROR_EitherExactOrPercentageCouldBeChosen_ERROR       (6202)
#define STTRADE_ERROR_ClientClassIsMissing_ERROR                (6203)
#define STTRADE_ERROR_RecordUpdatedBySomebodyElse_ERROR              (6934)
#define STTRADE_ERROR_LogInDisabled_ERROR                (8000)
#define STTRADE_ERROR_CellTypeSettingIsMissingOrInvalid_ERROR    (8007)
#define STTRADE_ERROR_MaximumAllowedUsersNotDefined_ERROR       (8016)
#define STTRADE_ERROR_UserProfileNotDefinedForUser_ERROR                (8017)
#define STTRADE_ERROR_NoOfLicencesPurchasedForProductNotSet_ERROR     (8018)
#define STTRADE_ERROR_NoProductGroupSelectedForUserProfile_ERROR         (8019)
#define STTRADE_ERROR_OrderValidityIsTooLong_ERROR                (8020)
#define STTRADE_ERROR_OrderInstructionIsTooLong_ERROR                (8021)
#define STTRADE_ERROR_LicenceNotCorrect_ERROR                (8100)
#define STTRADE_ERROR_DatabaseConnectionSettingsNotCorrect_ERROR        (8101)
#define STTRADE_ERROR_LogonFailure_ERROR                (8102)
#define STTRADE_ERROR_MachineNameinLicenseIncorrect_ERROR   (8103)
#define STTRADE_ERROR_LicenseHasNotBeenLoaded_ERROR                (8104)
#define STTRADE_ERROR_ClientBankAccountIsMissing_ERROR                (8205)
#define STTRADE_ERROR_ClientBankCodeIsMissing_ERROR                (8206)
#define STTRADE_ERROR_FilePathMissing_ERROR                (8207)
#define STTRADE_ERROR_ClientPasswordNotValidated_ERROR                (8208)
#define STTRADE_ERROR_InvalidSeriesGroup_ERROR                (8209)
#define STTRADE_ERROR_TargetMarketError_ERROR                (8301)
#define STTRADE_ERROR_TargetInstrumentError_ERROR                (8302)
#define STTRADE_ERROR_TargetPriceError_ERROR                (8303)
#define STTRADE_ERROR_TargetTimeError_ERROR                (8304)
#define STTRADE_ERROR_OrderPriceMustLessThanOrEqualToTargetPrice_ERROR  (8305)
#define STTRADE_ERROR_OrderPriceMustGreaterThanOrEqualToTargetPrice_ERRO (8306)
#define STTRADE_ERROR_InvalidStockOptionAccountType_ERROR   (8801)
#define STTRADE_ERROR_InvalidOpenAndClose_ERROR                (8802)
#define STTRADE_ERROR_RestrictedInstrumentGroupCodeMissing_ERROR        (8803)
#define STTRADE_ERROR_RequestNameNotExist_ERROR                (8888)
#define STTRADE_ERROR_FileNotFound_ERROR                (9001)
#define STTRADE_ERROR_FormatError_ERROR                (9002)
#define STTRADE_ERROR_DateError_ERROR                (9003)
#define STTRADE_ERROR_CodeForAccessProfileMissing_ERROR                (9005)
#define STTRADE_ERROR_CloseDateMustBeGreaterThanOpenDate_ERROR      (9008)
#define STTRADE_ERROR_CreditExpiryDateMustBeGreaterThanOpenDate_ERROR  (9009)
#define STTRADE_ERROR_ACCodeNotValid_ERROR                (9010)
#define STTRADE_ERROR_LicenceForGlobalMarketsHasNotBeenPurchased_ERROR (9011)
#define STTRADE_ERROR_ItemWasUpdatedByAnotherUser_ERROR        (16934)
#define STTRADE_ERROR_InvalidStatus_ERROR                (27000)
#define STTRADE_ERROR_QuantityExceedsOrder_ERROR                (27001)
#define STTRADE_ERROR_SalesCodeAlreadyExists_ERROR                (27002)
#define STTRADE_ERROR_A_CCodeNotValid_ERROR                (27003)
#define STTRADE_ERROR_InstrumentNotValid_AMC_ERROR                (27004)
#define STTRADE_ERROR_UserIDDoesNotExist_ERROR                (27005)
#define STTRADE_ERROR_DealerDoesNotExist_ERROR                (27006)
#define STTRADE_ERROR_QuantityMustBeGreaterThanZero_AMC_ERROR   (27007)
#define STTRADE_ERROR_AECodeNotValid_AMC_ERROR                (27008)
#define STTRADE_ERROR_CreditOfficerDoesNotExist_ERROR                (27009)
#define STTRADE_ERROR_DestinationAlreadyExists_ERROR                (27011)
#define STTRADE_ERROR_PasswordNotValid_ERROR                (27012)
#define STTRADE_ERROR_UserNotActive_ERROR                (27013)
#define STTRADE_ERROR_PasswordExpired_ERROR                (27014)
#define STTRADE_ERROR_PriceIsNotValid_ERROR                (27015)
#define STTRADE_ERROR_DeleteNotAllowed_ERROR                (27016)
#define STTRADE_ERROR_ClientGroupDoesNotExist_ERROR                (27017)
#define STTRADE_ERROR_InstrumentClassDoesNotExist_ERROR                (27018)
#define STTRADE_ERROR_OrderNotValid_ERROR                (27019)
#define STTRADE_ERROR_UpdateOrAddNotAllowed_ERROR                (27020)
#define STTRADE_ERROR_OrdersInformationNotMatched_ERROR          (27022)
#define STTRADE_ERROR_InstrumentExpired_ERROR                (27033)
#define STTRADE_ERROR_TradingNotAllowedInSelectedTradeDate_ERROR     (27024)
#define STTRADE_ERROR_SettlementNotAllowedInSelectedSettlementDate_ERROR   (27025)
#define STTRADE_ERROR_OrderAlreadyDeleted_ERROR                (27026)
#define STTRADE_ERROR_InvalidDELStatus_ERROR                (27027)
#define STTRADE_ERROR_InvalidCNGStatus_ERROR                (27028)
#define STTRADE_ERROR_ValueDateBeforeConfirmationDate_AMC_ERROR      (27200)
#define STTRADE_ERROR_RecordHasBeenDeleted_ERROR                (27888)
#define STTRADE_ERROR_RecordHasBeenUpdatedByAnotherUser_ERROR     (27890)
#define STTRADE_ERROR_RecordDeleteNotAllowed_ERROR                (27891)
#define STTRADE_ERROR_MissingUnderlyingStockBrokerNo_ERROR  (27896)
#define STTRADE_ERROR_InvalidTargetInstrument_ERROR                (27897)
#define STTRADE_ERROR_TradeDoesNotExists_ERROR                (27900)
#define STTRADE_ERROR_InvalidStatus_AMC_ERROR                (27901)
#define STTRADE_ERROR_DefaultBankNotFound_ERROR                (27902)
#define STTRADE_ERROR_DefaultDepotNotFound_ERROR                (27903)
#define STTRADE_ERROR_DefaultLocationNotFound_ERROR                (27904)
#define STTRADE_ERROR_CannotDeleteSystemUsedFields_ERROR             (27906)
#define STTRADE_ERROR_InvalidAmount_ERROR                (27907)
#define STTRADE_ERROR_ConfirmationDateExistForThisMarket_ERROR    (27908)
#define STTRADE_ERROR_ClientAlreadyExists_ERROR                (27909)
#define STTRADE_ERROR_StopOrderOverPriceRange_ERROR                (27910)
#define STTRADE_ERROR_StopOrderOverPricePercentRange_ERROR  (27911)
#define STTRADE_ERROR_StopOrderOverTradeLotLimit_ERROR                (27912)
#define STTRADE_ERROR_GroupCodeStillInUserByAtLeastOneUser_ERROR       (27913)
#define STTRADE_ERROR_LogInDisabled_AMC_ERROR                (28000)
#define STTRADE_ERROR_NoSuchRecord_ERROR                (28001)
#define STTRADE_ERROR_TransferAmountShouldBeGreaterThanZero_ERROR   (30001)
#define STTRADE_ERROR_TransferQuantityShouldBeGreaterThanZero_ERROR  (30002)
#define STTRADE_ERROR_InstrumentNotFound_ERROR                (50004)
#define STTRADE_ERROR_MarketNotFound_ERROR                (50012)
#define STTRADE_ERROR_FeeCurrencyNotFound_ERROR                (50013)
#define STTRADE_ERROR_NotAllActionTypesAreHandled_ERROR          (50042)
#define STTRADE_ERROR_MissingInstrument_ERROR                (50043)
#define STTRADE_ERROR_MissingMarket_ERROR                (50044)
#define STTRADE_ERROR_MissingCurrencyCode_ERROR                (50045)
#define STTRADE_ERROR_InstrumentLotSizeIsZeroOrNotFound_ERROR      (50081)
#define STTRADE_ERROR_DataNotChangedUpdateAborted_ERROR                (50203)
#define STTRADE_ERROR_ClientCodeIsMissing_ERROR                (50222)
#define STTRADE_ERROR_AccountTypeIsMissing_ERROR                (50223)
#define STTRADE_ERROR_QauntityForShareShouldBeGreaterThanOrEqualToZero_ERROR                (50226)
#define STTRADE_ERROR_QauntityForCashShouldBeGreaterThanOrEqualToZero_ERROR                (50227)
#define STTRADE_ERROR_FeeTypeNotYetSetupInFeeTable_ERROR                (50502)
#define STTRADE_ERROR_SettingNameIsUseByOthersRecords_ERROR             (50505)
#define STTRADE_ERROR_TradeHaveAlreadyBeenFullySettled_ERROR            (50506)
#define STTRADE_ERROR_CannotInsertDuplicateSettingName_ERROR            (50507)
#define STTRADE_ERROR_ClientIsInactive_ERROR                (50508)
#define STTRADE_ERROR_BuySellTypeIsNotValid_ERROR                (50509)
#define STTRADE_ERROR_InstrumentSeriesIsNotValid_ERROR                (50510)
#define STTRADE_ERROR_CustInfoIsNotValid_ERROR                (50511)
#define STTRADE_ERROR_OrderValidityIsNotValid_ERROR                (50512)
#define STTRADE_ERROR_InsertClientContactFailed_ERROR                (50513)
#define STTRADE_ERROR_UpdateClientContactFailed_ERROR                (50514)
#define STTRADE_ERROR_OrderInstructionIsNotValid_ERROR                (50515)
#define STTRADE_ERROR_InstrumentIsInactiveSuspended_ERROR                (50516)
#define STTRADE_ERROR_AccountTypeIsNotValid_ERROR                (50517)
//end

#define STTRADE_ERROR_NoAccountInList		(-89001)
#define STTRADE_ERROR_NoCommisionInfo		(-89002)

#define STTRADE_ERROR_ECG_FATALERROR		(-89003)
#define STTRADE_ERROR_ECG_COMMONERROR		(-89004)

#define STTRADE_ERROR_IND_FATALERROR		(-89010)

#define STTRADE_COMM_ERROR_START			(-79000)
#define STTRADE_COMM_ERROR_SEEMSG			(-79001)
#define STTRADE_COMM_ERROR_RTQDESC			(-79002)

#define STTRADE_COMM_ERROR_POSITIVE_START	(-70000)
#define STTRADE_COMM_ERROR_POSITIVE_END		(-60000)
#define STTRADE_COMM_CHECK_PASSWORDSTATUS	(-75000) //第一次登陆强制修改密码
#define STTRADE_COMM_CHECK_ORDERWARING	    (-900752) //下单校验

#define STTRADE_ERROR_NO_MARKET_ORDER		(-89011)

#define TRADE_ERROR_FFG_DONTACCEPTORDERATFOUR (-10000001)
#define TRADE_ERROR_FFG_REQUIRECLIENTACTIVATION (-10000002)

#pragma mark -

@protocol STFatalTradeErrorDelegate

- (void) onFatalTradeError:(id)err;

@end


@class STSYN_Action;
@class STHttpTradeClass;

@protocol STTradeActionTranslateProtocol<NSObject>

//@required + (NSObject*) allocTranslator_fromAction:(STSYN_Action*)act;
@required - (BOOL) readFromAction:(STSYN_Action*)act;
@required - (BOOL) writeToAction:(STSYN_Action*)act;

@end


@protocol STTradeActionTranslateProtocol_http<STTradeActionTranslateProtocol>

//@required @property(nonatomic, retain) NSString *doString;
//@required @property(nonatomic, retain) NSString *result;
@required -(NSString*) doString;
@required -(NSString*) result;

@required - (NSString*) allocString_forRequest;
@required - (NSString*) allocString_forResponse;
@required - (int) readString_fromResponse:(NSData*)data;
@required - (int) readString_fromResponseString:(NSString*)data;
@required - (int) readString_fromResponseStringEX:(NSString*)data;
@required - (int) readString_fromRequest:(NSString*)xmlString;
@required - (BOOL)readString_fromRequest_row:(NSString*)xmlString;
@required - (BOOL)readString_fromRequest_row_EX:(NSString *)xmlString beginStr:(NSString*)beginStr endStr:(NSString*) endStr;
@required - (BOOL)readString_fromRequest_row:(NSString*)xmlString records_start:(NSString*)records_start records_end:(NSString*)records_end ;
@end


@class STCommonError;
@protocol STTradeCommProtocol<NSObject>

@required - (void) setURL:(NSString*)urlH timeOut:(NSTimeInterval)t;

@required - (BOOL) doAction:(STSYN_Action*)act;

@required + (NSString*) getErrorDescByCode:(int)errCode;
@required + (BOOL) isErrorFatal:(int)errCode;
@required + (BOOL) isActCanPush:(STSYN_Action*)act;

@required - (NSString*) getErrorDescByCode:(int)errCode;
@required - (BOOL) isErrorFatal:(int)errCode;
@required - (BOOL) isActCanPush:(STSYN_Action*)act;

@optional - (NSString*) getErrorDescByDesc:(NSString*)desc;
@optional + (NSString*) getErrorDescByDesc:(NSString*)desc;

//@property (nonatomic, assign) NSUInteger lang;
@property (nonatomic, retain) NSString *broker;

@required - (id)findTodayOrder:(NSString *)orderID;

@end

@protocol STTradeCommProtocol_Http<STTradeCommProtocol>

@required - (STHttpTradeClass*) alloc_TranslatorFromAction:(STSYN_Action*)act;
@required - (int) writeResponse:(STHttpTradeClass*)res toAction:(STSYN_Action*)act;
@required - (BOOL) readRequest:(STHttpTradeClass*)res fromAction:(STSYN_Action*)act;
@required - (void) setTradeError:(STCommonError*)error fromCode:(int)c;
@end



@protocol STTradeCommProtocol_Http_XML<STTradeCommProtocol_Http>

@required - (id) alloc_TClassResponseWithElementName:(NSString*)parent_doString AND:(NSString*) child_responseTitle;
@required - (id) alloc_TClassRequestWithElementName:(NSString*)parent_doString AND:(NSString*) child_responseTitle;

@end


@protocol STMyClientComm_Protocol

- (void) onConnectOK;
- (void) onConnectFail:(NSError*)err;
- (void) tryConnect:(NSError*)err;
- (void) onProcRcvPackage:(char*)buf size:(int)sz;
- (void) onProcConnectFunc:(int) nType msg:(const char *)pMsg;

@end
