function BWL2=bwlpropfiltn(BWL,varargin)
%Generalization of bwpropfilt which supports N-dimensional logcial arrays
%or N-dimensional label matrices.
%
%The following syntaxes are supported and are analogous to bwpropfilt.
%
%     BWL2 = bwlpropfilt(BWL,attrib,range)
%     BWL2 = bwlpropfilt(BWL,attrib,n)
%     BWL2 = bwlpropfilt(BWL,attrib,n,keep)
%     BWL2 = bwlpropfilt(BWL,I,attrib,___)
%
%IN:
%
%         BWL: N-dimensional binary or label image input.
%           I: N-dimensional grayscale image same size as BWL
%      attrib: a region property, selected as  in bwpropfilt
%      n,keep: Same as in bwpropfilt.
% 
%OUT:
%
%       BWL2: ouutput N-dimensional binary or label image containing only
%             the selected objects.
%
%NOTES: Unlike bwpropfilt, alterantive connectivities 'conn' are not
%       supported. Only 3x3x3... connectivity is used.    


  %% Parse arguments
  
  if ~ischar(varargin{1})
      I=varargin{1};
      varargin(1)=[];
  else
      I=[];
  end

  attrib=varargin{1}; varargin(1)=[];
  
 if isscalar(varargin{1})
     n=varargin{1};
 else
     range=varargin{1};
     validateattributes(range,{'numeric'},{'numel',2,},'Range must be a vector')
 end
 varargin(1)=[];
 
 if ~isempty(varargin)
    if ischar(varargin{1})
        keep=varargin{1};
    else
        error 'conn argument not supported: 3x3x3... neighbourhoods assumed'
    end
 else
     keep='largest';
 end
 

 
  %% Region statistics
  
 if isempty(I)
   reg= regionprops(BWL,{attrib,'PixelIdxList'});
 else
   reg= regionprops(BWL,I,{attrib,'PixelIdxList'});  
 end
  propdata=[reg.(attrib)];
 
 %% Do Sorting
 
 
  if exist('range','var')
      
      idx = (propdata>=range(1) & propdata<=range(2) );
      
      
  else
      
      switch keep
          
          case 'largest'
         
               [~,idx]=maxk(propdata,n);
         
          case 'smallest'
              
              
               [~,idx]=mink(propdata,n);
      end
      
  
  end
  
  reg=reg(idx);
      
 
 
 
 %% Create output
 
 if islogical(BWL)
     
    BWL2=false(size(BWL));
    for i=1:numel(reg)
     BWL2(reg(i).PixelIdxList)=1;
    end
    
 else%labelmap
     
     BWL2=zeros(size(BWL),'like',BWL);
    for i=1:numel(reg)
     BWL2(reg(i).PixelIdxList)=i;
    end
     

 end