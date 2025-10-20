/**
~/cuda-hashing-algos/md5_test.sh
**/

#include <string>
#include <cassert>

extern "C" { 
  #include "md5.cuh"
}

std::string DescRaw( unsigned char* digest16 )
{
    char buf[32+1] ;
    for (int n = 0; n < 16; ++n) std::snprintf( &buf[2*n], 32+1, "%02x", (unsigned int)digest16[n]) ;
    buf[32] = '\0' ;
    return std::string(buf, buf + 32);
}

int main()
{
    const char* m = "hello" ;

    BYTE* in = (BYTE*)m ; 
    WORD inlen = strlen(m);
    assert( inlen == 5 );

    WORD n_batch = 1 ; 
    
    unsigned char digest[16] ; 
    BYTE* out = digest ; 

    mcm_cuda_md5_hash_batch(in, inlen, out, n_batch);

    std::string hexdigest = DescRaw( out );
    printf("// hexdigest [%s]\n", hexdigest.c_str() );

    return 0 ; 
}
