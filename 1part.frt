: check_parity
  dup 2 %
;

( x — )
( x -> 0/1 )
: store_res >r 8 allot dup r> swap ! ;

: check_prime ( x )
  dup 2 < if drop 0 store_res else
    ( x ) 
    dup 2
    for
      dup
      r@
      %
      not
      if r> r> drop drop drop 0 store_res exit then
    endfor
    drop 1 store_res
  then
;

: test_prime
  check_prime
  dup
  @
  .
  cr
;

: copy_string ( str addr — addr2 )
  swap
  dup
  count
  ( addr str len )

  0
  for ( addr str )
    dup c@
    ( addr str c )
    rot
    ( str c addr )
    dup
    ( str c addr addr )
    -rot
    ( str addr c addr )
    c!
    ( str addr )
    1 +
    swap
    1 +
  endfor
  drop
;

: concat ( str1 str2 — str1 + str2 )
  dup
  count
  ( str1 str2 len2 )
  rot
  ( str2 len2 str1 )
  dup
  count
  ( str2 len2 str1 len1 )
  rot
  ( str2 str1 len1 len2 )
  1 + +
  ( str2 str1 len1+len2+1  )

  heap-alloc
  ( str2 str1 addr )

  dup
  ( str2 str1 addr addr )
  rot
  ( str2 addr addr str1 )
  swap
  ( str2 addr str1 addr )

  copy_string
  ( str2 addr addr2 )

  rot
  ( addr addr2 str2 )
  swap
  ( addr str2 addr2 )

  copy_string
  ( addr addr3 )

  0
  swap
  c!

  ( addr )
;

: test
  m" 1213123"
  m" wsds"
  concat
  prints
  cr
;

: primarity ( x )
	dup 1 < if drop ." Не примарно" cr else
    ( x )
    dup 2
    for
      r>
      dup
      r@
      swap
      %
      if >r else
        dup dup r> swap / dup >r swap %
        if >r else
          r> drop drop drop ." Не примарно" cr exit
        then
      then
    endfor
    drop ." Примарно" cr
  then
;

: test_primarity
  30
  primarity
;