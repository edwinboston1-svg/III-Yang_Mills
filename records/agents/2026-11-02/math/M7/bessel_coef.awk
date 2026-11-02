# the gate's own COEFR generator (aperanton_table_gate.sh arm 10), parameterised: B = beta as a decimal, UP = 1 rounds each a_j UP at 10^-30
function I(n,x,  k,t,s){t=(x/2)^n; for(k=1;k<=n;k++) t/=k; s=t; for(k=0;k<400;k++){t*=(x/2)*(x/2)/((k+1)*(k+n+1)); s+=t} return s}
BEGIN{b=B+0; for(j2=1;j2<=16;j2++){r=I(j2+1,b)/I(1,b); n=int(r*1e30); if (UP) n=n+1; printf "%s%d/1000000000000000000000000000000", (j2>1?",":""), n}}
