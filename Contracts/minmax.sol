//SPDX-License-Identifier:MIT
pragma solidity ^0.8.8;

library minmax{
    
    function findMax(uint256 a, uint256 b, uint256 c, uint256 d) internal pure returns(uint256){
        uint256 maximumNumber1 = 0;
        uint256 maximumNumber2 = 0;
        uint256 f_maximumNumber = 0;
        

        if(a > b){
            maximumNumber1 = a;
        } else{
            maximumNumber1 = b;
        }

        if(c > d){
            maximumNumber2 = c;
        } else{
            maximumNumber2 = d;
        }

        if(maximumNumber1 > maximumNumber2){
            f_maximumNumber = maximumNumber1;
        } else{
            f_maximumNumber = maximumNumber2;
        }

        return f_maximumNumber;
    }
    
    
}