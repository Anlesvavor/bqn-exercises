h ← "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
HexToBase64 ← {
  ToNum ← (-@-⊢)¨
  IntDiv ← ⌊∘÷
  ToBase ← {
    r ← 𝕨 {𝕨>0 ? ((𝕨 IntDiv 𝕩) 𝕊 𝕩) ∾ (𝕨|˜𝕩) ; ⟨⟩} 𝕩
    {(≠𝕩)=0 ? ⟨0⟩ ; 𝕩} r
  }
  LeftPad ← { (≠𝕩)<𝕨 ? (𝕨 𝕊 (0 ∾ 𝕩)) ; 𝕩 }
  lettersMask ← (ToNum 'a')≤(ToNum 𝕩)
  numbersMask ← 1≠lettersMask
  temp1 ← numbersMask × ⟜ (((ToNum '0') -˜ ⊢)) (ToNum 𝕩)
  temp2 ← lettersMask × ⟜ (10+⊢)(((ToNum 'a') -˜ ⊢)) (ToNum 𝕩)
  bitstringTemp ← {(𝕩 ToBase 2)}¨ (temp1 + temp2)
  bitString ← ∾´{4 LeftPad 𝕩}¨ bitstringTemp
  base64Dict ← (('A'+↕26) ∾ ('a'+↕26) ∾ ('0'+↕10) ∾ "+/")
  {𝕩⊑base64Dict}¨ (+˝˘ {(2⋆⌽↕6)×𝕩}˘ (∘‿6 ⥊ bitstring))
}
HexToBase64 h
!("SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t" ≡ HexToBase64 h)
