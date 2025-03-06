classdef smallestinN_mask
  methods(Static)
    % Following properties of 'maskInitContext' are available to use:
    %  - BlockHandle
    %  - MaskObject
    %  - MaskWorkspace - Use get/set APIs to work with mask workspace.
    function MaskInitialization(maskInitContext)
      N = str2double(get_param(gcb, "N"));
      oldIn = find_system(gcb, "LookUnderMasks", "all", "FollowLinks", "on", ...
        "BlockType", "Inport");
      delete_block(oldIn);
      dispY = 20;
      pos = [10, 20, 40, 34];
      for I=1:N
        newPort = gcb+"/in"+string(I);
        add_block("simulink/Sources/In1", newPort, ...
          "Position", pos + [0, I*dispY, 0, I*dispY]);
      end
    end
  end
end