## Copyright (C) 2009-2016   Lukas F. Reichlin
##
## This file is part of LTI Syncope.
##
## LTI Syncope is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## LTI Syncope is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with LTI Syncope.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {} pzmap (@var{sys})
## @deftypefnx {Function File} {} pzmap (@var{sys1}, @var{sys2}, @dots{}, @var{sysN})
## @deftypefnx {Function File} {} pzmap (@var{sys1}, @var{'style1'}, @dots{}, @var{sysN}, @var{'styleN'})
## @deftypefnx {Function File} {[@var{p}, @var{z}] =} pzmap (@var{sys})
## Plot the poles and zeros of an LTI system in the complex plane.
## If no output arguments are given, the result is plotted on the screen.
## Otherwise, the poles and zeros are computed and returned.
##
## @strong{Inputs}
## @table @var
## @item sys
## @acronym{LTI} model.
## @item 'style'
## Line style and color, e.g. 'r' for a solid red line or '-.k' for a dash-dotted
## black line.  See @command{help plot} for details.
## @end table
##
## @strong{Outputs}
## @table @var
## @item p
## Poles of @var{sys}.
## @item z
## Invariant zeros of @var{sys}.
## @end table
## @end deftypefn

## Author: Lukas Reichlin <lukas.reichlin@gmail.com>
## Created: November 2009
## Version: 0.2

function [pol_r, zer_r] = pzmap2 (varargin)

  sys_idx = cellfun (@isa, varargin, {"lti"});      # look for LTI models
  sty_idx = cellfun (@ischar, varargin);            # look for strings (plot styles)

  inv_idx = ! (sys_idx | sty_idx);                  # invalid arguments
  

  pol = cellfun (@pole, varargin(sys_idx), "uniformoutput", false);
  zer = cellfun (@zero, varargin(sys_idx), "uniformoutput", false);

  if (! nargout)
    pol_re = cellfun (@real, pol, "uniformoutput", false);
    pol_im = cellfun (@imag, pol, "uniformoutput", false);
    zer_re = cellfun (@real, zer, "uniformoutput", false);
    zer_im = cellfun (@imag, zer, "uniformoutput", false);

    ## extract plotting styles
    tmp = cumsum (sys_idx);
    tmp(sys_idx | ! sty_idx) = 0;
    n = nnz (sys_idx);
    sty = arrayfun (@(x) varargin(tmp == x), 1:n, "uniformoutput", false);

    colororder = get (gca, "colororder");
    rc = rows (colororder);
    def_pol = arrayfun (@(k) {"x", "color", colororder(1+rem (k-1, rc), :)}, 1:n, "uniformoutput", false);
    def_zer = arrayfun (@(k) {"o", "color", colororder(1+rem (k-1, rc), :)}, 1:n, "uniformoutput", false);
    idx = cellfun (@isempty, sty);
    sty_pol = sty_zer = sty;
    sty_pol(idx) = def_pol(idx);
    sty_zer(idx) = def_zer(idx);

    pol_args = horzcat (cellfun (@horzcat, pol_re, pol_im, sty_pol, "uniformoutput", false){:});
    zer_args = horzcat (cellfun (@horzcat, zer_re, zer_im, sty_zer, "uniformoutput", false){:});

    leg_args = cell (1, n);
    idx = find (sys_idx);
    for k = 1 : n
      try
        leg_args{k} = inputname (idx(k));
      catch
        leg_args{k} = "";       # needed for  pzmap (lticell{:})
      end_try_catch
    endfor

    ## FIXME: try to combine "x", "o" and style for custom colors

    ## If no zeroes then just plot the poles and vice versa
    if (isempty ( zer{:}))
       h = plot (pol_args{:});
    elseif  (isempty ( pol{:}))
       h = plot (zer_args{:});
    else
       h = plot (pol_args{:}, "markersize", 10, "linewidth", 5, zer_args{:}, "markersize", 10, "linewidth", 5);
    endif

    grid ("on")  
    title ("Diagrama de polos y ceros")
    xlabel ("Re[z]")
    ylabel ("Im[z]")
    %legend (h(1:n), leg_args)
  else
    pol_r = pol{1};
    zer_r = zer{1};
  endif
  
endfunction

%!demo
%! s = tf('s');
%! g = (s-1)/(s-2)/(s-3);
%! pzmap(g);

%!test
%! s = tf('s');
%! g = (s-1)/(s-2)/(s-3);
%! [pol zer] = pzmap(g);
%! assert(sort(pol), [2 3]', 2*eps);
%! assert(zer, 1, eps);

%!demo
%! s = tf('s');
%! g = 1/(2*s^2+3*s+4);
%! pzmap(g);

%!test
%! s = tf('s');
%! g = 1/(2*s^2+3*s+4);
%! pol = pzmap(g);
%! assert(sort(pol), sort(roots([2 3 4]')), eps);
