//
//  NSError+Errno.m
//  WordBase
//
//  Created by Dmitry Feld on 8/4/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import "NSError+Errno.h"

const NSString* kDFWBErrnoErrorsDomain          = @"kDFWBErrnoErrorsDomain";

/*
const NSString* kDFWBOperationNotPermitted 		= @"Operation not permitted";
const NSString* kDFWBNoSuchFileOrDirectory 		= @"No such file or directory";
const NSString* kDFWBNoSuchProcess              = @"No such process";
const NSString* kDFWBInterruptedSystemCall		= @"Interrupted system call";
const NSString* kDFWBIOError                    = @"I/O error";
const NSString* kDFWBNoSuchDeviceOrAddress 		= @"No such device or address";
const NSString* kDFWBArgumentListTooLong 		= @"Argument list too long";
const NSString* kDFWBExecFormatError	 		= @"Exec format error";
const NSString* kDFWBBadFileNumber              = @"Bad file number";
const NSString* kDFWBNoChildProcessed 			= @"No child processes";
const NSString* kDFWBTryAgain                   = @"Try again";
const NSString* kDFWBOutOfMemory                = @"Out of memory";
const NSString* kDFWBPermissionDenied 			= @"Permission denied";
const NSString* kDFWBBadAddress                 = @"Bad address";
const NSString* kDFWBBlcokDeviceRequired		= @"Block device required";
const NSString* kDFWBDeviceOrResourceBusy 		= @"Device or resource busy";
const NSString* kDFWBFileExists                 = @"File exists";
const NSString* kDFWBCrossDeviceLink 			= @"Cross-device link";
const NSString* kDFWBNoSuchDevice               = @"No such device";
const NSString* kDFWBNotADirectory              = @"Not a directory";
const NSString* kDFWBIsADirectory               = @"Is a directory";
const NSString* kDFWBInvalidArgument 			= @"Invalid argument";
const NSString* kDFWBFileTableOverflow          = @"File table overflow";
const NSString* kDFWBTooManyOpenFiles 			= @"Too many open files";
const NSString* kDFWBNotATypewriter 			= @"Not a typewriter";
const NSString* kDFWBTextFileTooBusy 			= @"Text file busy";
const NSString* kDFWBFileTooLarge               = @"File too large";
const NSString* kDFWBNoSpaceLeftOnDevice 		= @"No space left on device";
const NSString* kDFWBIllegalSeek                = @"Illegal seek";
const NSString* kDFWBReadOnlyFileSystem 		= @"Read-only file system";
const NSString* kDFWBTooManyLinks               = @"Too many links";
const NSString* kDFWBBrokenPipe                 = @"Broken pipe";
const NSString* kDFWBMathArgOutOfDomainOfFunc   = @"Math argument out of domain of func";
const NSString* kDFWBMathResultNotRepresentable = @"Math result not representable";

const NSString* kDFWBResourceDeadlockWouldOccur = @"Resource deadlock would occur";
const NSString* kDFWBFileNameTooLong 			= @"File name too long";
const NSString* kDFWBNoRecordLocksAvailable     = @"No record locks available";
const NSString* kDFWBFunctionNotImplemented     = @"Function not implemented";
const NSString* kDFWBDirectoryNotEmpty          = @"Directory not empty";
const NSString* kDFWBTooManySymbolicLinks 		= @"Too many symbolic links encountered";
const NSString* kDFWBOperationWouldBlock	 	= @"Operation would block";
const NSString* kDFWBNoMessageOfDesiredType     = @"No message of desired type";
const NSString* kDFWBIdentifierRemoved          = @"Identifier removed";
const NSString* kDFWBChannelNumberOutOfRange    = @"Channel number out of range";
const NSString* kDFWBLevel2NotSynchronized		= @"Level 2 not synchronized";
const NSString* kDFWBLevel3Halted               = @"Level 3 halted";
const NSString* kDFWBLevel3Reset                = @"Level 3 reset";
const NSString* kDFWBLinkNumberOutOfRange 		= @"Link number out of range";
const NSString* kDFWBProtocolDriverNotAttached 	= @"Protocol driver not attached";
const NSString* kDFWBNoCSIStructureAvailable    = @"No CSI structure available";
const NSString* kDFWBLevel2Halted               = @"Level 2 halted";
const NSString* kDFWBInvalidExchange 			= @"Invalid exchange";
const NSString* kDFWBInvalidRequestDescriptor   = @"Invalid request descriptor";
const NSString* kDFWBExchangeFull               = @"Exchange full";
const NSString* kDFWBNoAnode                    = @"No anode";
const NSString* kDFWBInvalidRequestCode 		= @"Invalid request code";
const NSString* kDFWBInvalidSlot                = @"Invalid slot";

const NSString* kDFWBDeadlock                   = @"Deadlock";

const NSString* kDFWBBadFontFileFormat          = @"Bad font file format";
const NSString* kDFWBDeviceNotAStream 			= @"Device not a stream";
const NSString* kDFWBNoDataAvailable 			= @"No data available";
const NSString* kDFWBTimerExpired               = @"Timer expired";
const NSString* kDFWBOutOfStreamsResources 		= @"Out of streams resources";
const NSString* kDFWBMachineIsNotOnTheNetwork   = @"Machine is not on the network";
const NSString* kDFWBPackageNotInstalled 		= @"Package not installed";
const NSString* kDFWBObjectIsRemote 			= @"Object is remote";
const NSString* kDFWBLinkHasBeenSevered 		= @"Link has been severed";
const NSString* kDFWBAdvertiseError 			= @"Advertise error";
const NSString* kDFWBSrmountError               = @"Srmount error";
const NSString* kDFWBCommunicationErrorOnSend   = @"Communication error on send";
const NSString* kDFWBProtocolError              = @"Protocol error";
const NSString* kDFWBMultihopAttempted          = @"Multihop attempted";
const NSString* kDFWBRFSSpecificError 			= @"RFS specific error";
const NSString* kDFWBNotADataMessage 			= @"Not a data message";
const NSString* kDFWBValueTooLarge              = @"Value too large for defined data type";
const NSString* kDFWBNameNotUniqueOnNetwork     = @"Name not unique on network";
const NSString* kDFWBFileDescriptorInBadState   = @"File descriptor in bad state";
const NSString* kDFWBRemoteAddressChanged 		= @"Remote address changed";
const NSString* kDFWBCanNotAccessLibrary        = @"Can not access a needed shared library";
const NSString* kDFWBAccessingCorruptedLibrary  = @"Accessing a corrupted shared library";
const NSString* kDFWBLibSectionInAOutCorrupted 	= @".lib section in a.out corrupted";
const NSString* kDFWBTooManyAttemptsToLink	 	= @"Attempting to link in too many shared libraries";
const NSString* kDFWBCannotExecSharedLibrary    = @"Cannot exec a shared library directly";
const NSString* kDFWBIllegalByteSequence 		= @"Illegal byte sequence";
const NSString* kDFWBSystemCallShouldRestart    = @"Interrupted system call should be restarted";
const NSString* kDFWBStreamsPipeError 			= @"Streams pipe error";
const NSString* kDFWBTooManyUsers               = @"Too many users";
const NSString* kDFWBInvalicSocketOperation     = @"Socket operation on non-socket";
const NSString* kDFWBDestinationAddressRequired = @"Destination address required";
const NSString* kDFWBMessageTooLong 			= @"Message too long";
const NSString* kDFWBInvalidProtocolType 		= @"Protocol wrong type for socket";
const NSString* kDFWBProtocolNotAvailable 		= @"Protocol not available";
const NSString* kDFWBProtocolNotSupported 		= @"Protocol not supported";
const NSString* kDFWBSocketTypeNotSupported     = @"Socket type not supported";
const NSString* kDFWBOperationNotSupported 		= @"Operation not supported on transport endpoint";
const NSString* kDFWBProtocolFamilyNotSupported = @"Protocol family not supported";
const NSString* kDFWBAddressFamilyNotSupported 	= @"Address family not supported by protocol";
const NSString* kDFWBAddressAlreadyInUse 		= @"Address already in use";
const NSString* kDFWBCannotAssignAddress        = @"Cannot assign requested address";
const NSString* kDFWBNetworkIsDown              = @"Network is down";
const NSString* kDFWBNetworkIsUnreachable 		= @"Network is unreachable";
const NSString* kDFWBNetworkReset               = @"Network dropped connection because of reset";
const NSString* kDFWBSoftwareConnectionAbort    = @"Software caused connection abort";
const NSString* kDFWBConnectionResetByPeer 		= @"Connection reset by peer";
const NSString* kDFWBNoBufferSpaceAvailable     = @"No buffer space available";
const NSString* kDFWBTransportIsConnected       = @"Transport endpoint is already connected";
const NSString* kDFWBTransportNotConnected 		= @"Transport endpoint is not connected";
const NSString* kDFWBCannotSend                 = @"Cannot send after transport endpoint shutdown";
const NSString* kDFWBTooManyReferences			= @"Too many references: cannot splice";
const NSString* kDFWBConnectionTimedOut 		= @"Connection timed out";
const NSString* kDFWBConnectionRefused          = @"Connection refused";
const NSString* kDFWBHostIsDown                 = @"Host is down";
const NSString* kDFWBNoRouteToHost              = @"No route to host";
const NSString* kDFWBOperationAlreadyInProgress = @"Operation already in progress";
const NSString* kDFWBOperationNowInProgress     = @"Operation now in progress";
const NSString* kDFWBStaleNFSFileHandle 		= @"Stale NFS file handle";
const NSString* kDFWBStructureNeedsCleaning     = @"Structure needs cleaning";
const NSString* kDFWBNotXENIXNamedTypeFile 		= @"Not a XENIX named type file";
const NSString* kDFWBNoXENIXSemaphores  		= @"No XENIX semaphores available";
const NSString* kDFWBIsNamedTypeFile 			= @"Is a named type file";
const NSString* kDFWBRemoteIOError              = @"Remote I/O error";
const NSString* kDFWBQuotaExceeded              = @"Quota exceeded";

const NSString* kDFWBNoMediumFound              = @"No medium found";
const NSString* kDFWBWrongMediumType 			= @"Wrong medium type";
const NSString* kDFWBOperationCanceled          = @"Operation Canceled";
const NSString* kDFWBKeyNotAvailable 			= @"Required key not available";
const NSString* kDFWBKeyExpired                 = @"Key has expired";
const NSString* kDFWBKeyRevoked                 = @"Key has been revoked";
const NSString* kDFWBKeyWasRejected 			= @"Key was rejected by service";

const NSString* kDFWBOwnerDied                  = @"Owner died";
const NSString* kDFWBStateNotRecoverable 		= @"State not recoverable";
 
const NSString* kDFWBFileOpen                   = @"File already open";
const NSString* kDFWBFileOpen                   = @"File already closed";
*/


NSString* const __kDFWBErrnoMessages[] = {
    @"Operation not permitted",
    @"No such file or directory",
    @"No such process",
    @"Interrupted system call",
    @"I/O error",
    @"No such device or address",
    @"Argument list too long",
    @"Exec format error",
    @"Bad file number",
    @"No child processes",
    @"Try again",
    @"Out of memory",
    @"Permission denied",
    @"Bad address",
    @"Block device required",
    @"Device or resource busy",
    @"File exists",
    @"Cross-device link",
    @"No such device",
    @"Not a directory",
    @"Is a directory",
    @"Invalid argument",
    @"File table overflow",
    @"Too many open files",
    @"Not a typewriter",
    @"Text file busy",
    @"File too large",
    @"No space left on device",
    @"Illegal seek",
    @"Read-only file system",
    @"Too many links",
    @"Broken pipe",
    @"Math argument out of domain of func",
    @"Math result not representable",
    
    @"Resource deadlock would occur",
    @"File name too long",
    @"No record locks available",
    @"Function not implemented",
    @"Directory not empty",
    @"Too many symbolic links encountered",
    @"Operation would block",
    @"No message of desired type",
    @"Identifier removed",
    @"Channel number out of range",
    @"Level 2 not synchronized",
    @"Level 3 halted",
    @"Level 3 reset",
    @"Link number out of range",
    @"Protocol driver not attached",
    @"No CSI structure available",
    @"Level 2 halted",
    @"Invalid exchange",
    @"Invalid request descriptor",
    @"Exchange full",
    @"No anode",
    @"Invalid request code",
    @"Invalid slot",
    
    @"Bad font file format",
    @"Device not a stream",
    @"No data available",
    @"Timer expired",
    @"Out of streams resources",
    @"Machine is not on the network",
    @"Package not installed",
    @"Object is remote",
    @"Link has been severed",
    @"Advertise error",
    @"Srmount error",
    @"Communication error on send",
    @"Protocol error",
    @"Multihop attempted",
    @"RFS specific error",
    @"Not a data message",
    @"Value too large for defined data type",
    @"Name not unique on network",
    @"File descriptor in bad state",
    @"Remote address changed",
    @"Can not access a needed shared library",
    @"Accessing a corrupted shared library",
    @".lib section in a.out corrupted",
    @"Attempting to link in too many shared libraries",
    @"Cannot exec a shared library directly",
    @"Illegal byte sequence",
    @"Interrupted system call should be restarted",
    @"Streams pipe error",
    @"Too many users",
    @"Socket operation on non-socket",
    @"Destination address required",
    @"Message too long",
    @"Protocol wrong type for socket",
    @"Protocol not available",
    @"Protocol not supported",
    @"Socket type not supported",
    @"Operation not supported on transport endpoint",
    @"Protocol family not supported",
    @"Address family not supported by protocol",
    @"Address already in use",
    @"Cannot assign requested address",
    @"Network is down",
    @"Network is unreachable",
    @"Network dropped connection because of reset",
    @"Software caused connection abort",
    @"Connection reset by peer",
    @"No buffer space available",
    @"Transport endpoint is already connected",
    @"Transport endpoint is not connected",
    @"Cannot send after transport endpoint shutdown",
    @"Too many references: cannot splice",
    @"Connection timed out",
    @"Connection refused",
    @"Host is down",
    @"No route to host",
    @"Operation already in progress",
    @"Operation now in progress",
    @"Stale NFS file handle",
    @"Structure needs cleaning",
    @"Not a XENIX named type file",
    @"No XENIX semaphores available",
    @"Is a named type file",
    @"Remote I/O error",
    @"Quota exceeded",
    
    @"No medium found",
    @"Wrong medium type",
    @"Operation Canceled",
    @"Required key not available",
    @"Key has expired",
    @"Key has been revoked",
    @"Key was rejected by service",
    
    @"Owner died",
    @"State not recoverable",
    
    @"File already open",
    @"File already closed"
};


@implementation NSError(Errno)
+ (NSError*) errorWithCode:(uint16_t)code {
    NSError* result = nil;
    if (code > 0) {
        if (code < 132) {
            NSString* message = __kDFWBErrnoMessages[code];
            result = [NSError errorWithDomain:(NSString*)kDFWBErrnoErrorsDomain code:code userInfo:@{NSLocalizedDescriptionKey:message}];
        }
    }
    return result;
}
@end
