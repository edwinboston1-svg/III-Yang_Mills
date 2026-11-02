# rateA.awk -- the asymptotic rate of K0(D) (road A kernel): log(|K0(D1)|/|K0(D2)|)/(D2-D1), D2 the last D with |K0| > 1e-11 |K0(0)|, D1 = max(3, D2/2)
/^A / { line=$0; gsub(/= /,"=",line); n=split(line,f," "); for(i=1;i<=n;i++){ if(f[i] ~ /^D=/){split(f[i],a,"="); D=a[2]+0} if(f[i] ~ /^K0=/){split(f[i],b,"="); v[D]=b[2]+0; if(D>mx) mx=D} } }
END { v0 = (v[0]<0?-v[0]:v[0]); D2=0; for(D=1; D<=mx; D++){ x=(v[D]<0?-v[D]:v[D]); if (x > 1e-11*v0) D2=D; else break }
  D1 = int(D2/2); if (D1 < 3) D1 = 3; if (D2 <= D1) { print "nan"; exit }
  x1=(v[D1]<0?-v[D1]:v[D1]); x2=(v[D2]<0?-v[D2]:v[D2]); printf "%.6f\n", log(x1/x2)/(D2-D1) }
