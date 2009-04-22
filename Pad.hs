module Pad (
	Pad(..),
	padU, padD, padL, padR, padA, padB,
	initialPad,
	updatePad,
	pressing,
	justPressed
) where

import Data.Bits ((.&.), (.|.), complement, shiftL)

-- Pad

data Pad = Pad {
	curr :: Int,
	prev :: Int
	}

initialPad = Pad { curr = complement 0, prev = complement 0 }

padU = 1 `shiftL` 0 :: Int
padD = 1 `shiftL` 1 :: Int
padL = 1 `shiftL` 2 :: Int
padR = 1 `shiftL` 3 :: Int
padA = 1 `shiftL` 4 :: Int
padB = 1 `shiftL` 5 :: Int

updatePad :: Pad -> Int -> Pad
updatePad opad btn =
	Pad {
		curr = btn,
		prev = curr opad
	}

pressing :: Pad -> Int -> Bool
pressing pad btn = (curr pad .&. btn) /= 0

justPressed :: Pad -> Int -> Bool
justPressed pad btn = (trg .&. btn) /= 0
	where
		trg = curr pad .&. complement (prev pad)
