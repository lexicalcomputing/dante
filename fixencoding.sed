#!/usr/bin/sed -f
# C2/C3 is suspicious, in UTF-8 it means codepoints 128–255 (U+80–U+FF), which were originally Windows-1252 but got interpreted as ISO 8859-1 and naively encoded into Unicode/UTF-8
# longer sequences ([\xc2\xc3].){2,} are likely crippled Unicode instead, cf. https://stackoverflow.com/questions/60940414/apostrophe-in-postgresql-query-comes-out-32-bit-c3-a2-c2-80
# see also https://stackoverflow.com/questions/19109899/what-is-the-exact-difference-between-windows-1252-and-iso-8859-1
s/\xc3\xa2\xc2\x80\xc2\x93/–/g
s/\xc3\xa2\xc2\x80\xc2\x94/—/g
s/\xc3\xa2\xc2\x80\xc2\x98/‘/g
s/\xc3\xa2\xc2\x80\xc2\x99/’/g
s/\xc3\xa2\xc2\x80\xc2\x9a/‚/g
s/\xc3\xa2\xc2\x80\xc2\x9c/“/g
s/\xc3\xa2\xc2\x80\xc2\x9d/”/g
s/\xc3\xa2\xc2\x80\xc2\x9e/„/g
s/\xc3\xa2\xc2\x80\xc2\xa0/†/g
s/\xc3\xa2\xc2\x80\xc2\xa1/‡/g
s/\xc3\xa2\xc2\x80\xc2\xa2/•/g
s/\xc3\xa2\xc2\x80\xc2\xa6/…/g
s/\xc3\xa2\xc2\x80\xc2\xb0/‰/g
s/\xc3\xa2\xc2\x80\xc2\xb9/‹/g
s/\xc3\xa2\xc2\x80\xc2\xba/›/g
s/\xc3\xa2\xc2\x80\xc5\xa0/\xe2\x81\xa0/g
s/\xc3\xa2\xc2\x82\xc2\xac/€/g
s/\xc3\xa2\xc2\x84\xc2\xa2/™/g
# some bytes have disappeared at borders of text nodes
s/>\xc2\x80\xc2\x9c/>“/g
s/\xc3\xa2\xc2\x80</”</g
# double encoded bytes
s/\xc3\x85\xc2\x92/Œ/g
s/\xc3\x85\xc2\x93/œ/g
s/\xc3\x85\xc2\xa0/Š/g
s/\xc3\x85\xc2\xa1/š/g
s/\xc3\x85\xc2\xb8/Ÿ/g
s/\xc3\x85\xc2\xbd/Ž/g
s/\xc3\x85\xc2\xbe/ž/g
s/\xc3\x86\xc2\x92/ƒ/g
s/\xc3\x8b\xc2\x86/ˆ/g
s/\xc3\x8b\xc2\x9c/˜/g
# wrongly encoded bytes
s/\xc2\x80/€/g
s/\xc2\x82/‚/g
s/\xc2\x83/ƒ/g
s/\xc2\x84/„/g
s/\xc2\x85/…/g
s/\xc2\x86/†/g
s/\xc2\x87/‡/g
s/\xc2\x88/ˆ/g
s/\xc2\x89/‰/g
s/\xc2\x8a/Š/g
s/\xc2\x8b/‹/g
s/\xc2\x8c/Œ/g
s/\xc2\x8e/Ž/g
s/\xc2\x91/‘/g
s/\xc2\x92/’/g
s/\xc2\x93/“/g
s/\xc2\x94/”/g
s/\xc2\x95/•/g
s/\xc2\x96/–/g
s/\xc2\x97/—/g
s/\xc2\x98/˜/g
s/\xc2\x99/™/g
s/\xc2\x9a/š/g
s/\xc2\x9b/›/g
s/\xc2\x9c/œ/g
s/\xc2\x9e/ž/g
s/\xc2\x9f/Ÿ/g
# reencoding of single bytes
s/\([\x00-\x79]\)\x80/\1€/g
s/\([\x00-\x79]\)\x82/\1‚/g
s/\([\x00-\x79]\)\x83/\1ƒ/g
s/\([\x00-\x79]\)\x84/\1„/g
s/\([\x00-\x79]\)\x85/\1…/g
s/\([\x00-\x79]\)\x86/\1†/g
s/\([\x00-\x79]\)\x87/\1‡/g
s/\([\x00-\x79]\)\x88/\1ˆ/g
s/\([\x00-\x79]\)\x89/\1‰/g
s/\([\x00-\x79]\)\x8a/\1Š/g
s/\([\x00-\x79]\)\x8b/\1‹/g
s/\([\x00-\x79]\)\x8c/\1Œ/g
s/\([\x00-\x79]\)\x8e/\1Ž/g
s/\([\x00-\x79]\)\x91/\1‘/g
s/\([\x00-\x79]\)\x92/\1’/g
s/\([\x00-\x79]\)\x93/\1“/g
s/\([\x00-\x79]\)\x94/\1”/g
s/\([\x00-\x79]\)\x95/\1•/g
s/\([\x00-\x79]\)\x96/\1–/g
s/\([\x00-\x79]\)\x97/\1—/g
s/\([\x00-\x79]\)\x98/\1˜/g
s/\([\x00-\x79]\)\x99/\1™/g
s/\([\x00-\x79]\)\x9a/\1š/g
s/\([\x00-\x79]\)\x9b/\1›/g
s/\([\x00-\x79]\)\x9c/\1œ/g
s/\([\x00-\x79]\)\x9e/\1ž/g
s/\([\x00-\x79]\)\x9f/\1Ÿ/g
# double-encoded entities (most of them HTML only, some of them non-standard), &figure; is missing essential information
s/&amp;# *\([^ ;]*\) *;/\&#\1;/g
s/&amp; hellip ;/…/g
s/&amp; hellip;/…/g
s/&amp;nbsp;/ /g
s/&amp; AMP ;/\&amp;/g
s/&amp; AMP;/\&amp;/g
s/&amp; formula ;/(formula)/g
s/&amp; bull ;/•/g
s/&amp;AD ;/AD/g
s/&amp;BC;/BC/g
s/&amp; pound;/£/g
s/&amp; rcaron ;/ř/g
s/&amp; amacr ;/ā/g
s/&amp;mu;/μ/g
s/&amp; agr ;/α/g
s/&amp; bgr ;/β/g
s/&amp; Bgr ;/Β/g
s/&amp; egr ;/∈/g
s/&amp; Ggr ;/Γ/g
s/&amp; ohgr ;/ω/g
s/&amp;omega ;/ω/g
s/&amp;omega;/ω/g
s/&amp;Omega;/Ω/g
s/&amp; phgr ;/φ/g
s/&amp;Phi ;/Φ/g
s/&amp;pi;/π/g
s/&amp; sgr ;/σ/g
s/&amp;xi ;/ξ/g
s/&amp;le;/≤/g
s/&amp;plusmn;/±/g
s/&amp;quot ;/\&quot;/g
s/&amp;quot;/\&quot;/g
s/&amp; # 173/\&#173;/g
s/&amp; ; /\&amp;/g
s/&amp; amp; amp;/\&amp;/g
s/&amp; amp;/\&amp;/g
s/&amp;dagger ;/†/g
s/&amp;Dagger ;/‡/g
s/&amp; dstrok ;/đ/g
s/&amp;eacute;/é/g
s/&amp;endash;/–/g
s/&amp;fnof;/ƒ/g
s/&amp; frac23 ;/⅔/g
s/&amp;ge;/≥/g
s/&amp;gt;/\&gt;/g
s/&amp;harr ;/↔/g
s/&amp; oelig ;/œ/g
s/&amp;on;/ on /g
s/&amp;rarr;/→/g
s/&amp;sbquo;/‚/g
s/&amp; scaron ;/š/g
s/&amp; Scaron ;/Š/g
s/&amp; scedil ;/ş/g
s/&amp; scirc ;/ŝ/g
s/&amp; sharp;/♯/g
s/&amp;trade ;/™/g
s/&amp;trade;/™/g
s/&amp;shy;/­/g
