import { useEffect, useState } from "react";
import { execHaloCmdWeb } from "@arx-research/libhalo/api/web.js";
import { HeyAuthn } from "@semaphore-protocol/heyauthn";
import { heyAuthnOptions } from "./CreateGroup";

export const Scan = () => {
  const [statusText, setStatusText] = useState("Waiting for NFC setup...");

  useEffect(() => {
    async function runScan() {
      const { identity } = await HeyAuthn.fromRegister(heyAuthnOptions);

      // fill identity commitment to 32 bytes
      const commitment = identity.commitment;
      const commitmentHex = commitment.toString(16);
      const commitmentPadded = commitmentHex.padStart(64, "0");

      const command = {
        name: "sign",
        keyNo: 1,
        digest: commitmentPadded,
      };

      let res;
      try {
        res = await execHaloCmdWeb(command, {
          statusCallback: (cause: string) => {
            if (cause === "init") {
              setStatusText(
                "Please tap the tag to the back of your smartphone and hold it..."
              );
            } else if (cause === "retry") {
              setStatusText(
                "Something went wrong, please try to tap the tag again..."
              );
            } else if (cause === "scanned") {
              setStatusText(
                "Tag scanned successfully, post-processing the result..."
              );
            } else {
              setStatusText(cause);
            }
          },
        });
        setStatusText(res.signature + "/n" + res.publicKey);
      } catch (e) {
        setStatusText("Scanning failed, reload page to retry.");
      }
    }

    runScan();
  }, []);

  return (
    <>
      <div>Status: {statusText}</div>
    </>
  );
};
