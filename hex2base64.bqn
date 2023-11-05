ToASCII ← (-@-⊢)¨
IntDiv ← ⌊∘÷
ToBase ← {
  r ← 𝕨 {𝕨>0 ? ((𝕨 IntDiv 𝕩) 𝕊 𝕩) ∾ (𝕨|˜𝕩) ; ↕0} 𝕩
  {(≠𝕩)=0 ? ⟨0⟩ ; 𝕩} r
}
LeftPad ← { (≠𝕩)<𝕨 ? (𝕨 𝕊 (0 ∾ 𝕩)) ; 𝕩 }

hexDict ← (('0'+↕10) ∾ ('a'+↕6))
base64Dict ← (('A'+↕26) ∾ ('a'+↕26) ∾ ('0'+↕10) ∾ "+/")
HexToBitstring ← {
  lettersMask ← 'a' ≤○ToASCII 𝕩
  numbersMask ← 1≠lettersMask
  temp1 ← numbersMask × ⟜ (((ToASCII '0') -˜ ⊢)) (ToASCII 𝕩)
  temp2 ← lettersMask × ⟜ (10+⊢)(((ToASCII 'a') -˜ ⊢)) (ToASCII 𝕩)
  bitstringTemp ← {(𝕩 ToBase 2)}¨ (temp1 + temp2)
  bitString ← ∾´{4 LeftPad 𝕩}¨ bitstringTemp
  bitString
}
BitsToDec ← {
  +˝˘ ((2⋆⌽↕𝕨)×⊢)˘ (∘‿𝕨 ⥊ 𝕩)
}
HexToBase64 ← {
  (base64Dict⊑˜⊢)¨ (6 BitsToDec (HexToBitString 𝕩))
}
h ← "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
•Show HexToBase64 h
!("SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t" ≡ HexToBase64 h)

FixedXOR ← (hexDict⊑˜⊢)¨∘(4 BitsToDec⊢)∘≠○HexToBitString
a ← "1c0111001f010100061a024b53535009181c"
b ← "686974207468652062756c6c277320657965"
•Show a FixedXOR b
!("746865206b696420646f6e277420706c6179" ≡ a FixedXOR b)
